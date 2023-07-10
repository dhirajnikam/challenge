import 'package:challenge148/model/device_model.dart';
import 'package:challenge148/utils/sql_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  final DeviceProfileDatabase database = DeviceProfileDatabase();
  List<DeviceProfile> deviceProfiles = [];
  bool isLoading = false;
  late DeviceProfile _selectedProfile;

  DeviceProfile get selectedProfile => _selectedProfile;

  Future<void> loadDeviceProfiles() async {
    try {
      isLoading = true;

      await database.openDatabase();
      deviceProfiles = await database.getAllDeviceProfiles();
      print(deviceProfiles.length);

      isLoading = false;
      update();
    } catch (e) {
      print(e);
      isLoading = false;
      update();
    }
  }

  Future<void> deleteDeviceProfiles(int id) async {
    try {
      isLoading = true;

      await database.openDatabase();
      await database.deleteDeviceProfile(id);
      print(deviceProfiles.length);

      isLoading = false;
      update();
    } catch (e) {
      print(e);
      isLoading = false;
      update();
    }
  }

  void setSelectedProfile(DeviceProfile profile) {
    _selectedProfile = profile;
    _updateAppTheme();
    Get.back();
    update();
  }

  void _updateAppTheme() {
    final primaryColor = MaterialColor(
      int.parse(selectedProfile.themeColor),
      <int, Color>{},
    );

    Get.changeTheme(ThemeData(
      primaryColor: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ));
  }

  RxString name = ''.obs;
  Rx<Color> color = Colors.blue.obs; // Updated to Rx<Color>
  RxDouble textSize = 16.0.obs;
  RxString latitude = '0.0'.obs;
  RxString longitude = '0.0'.obs;
  RxBool showColorPicker = false.obs;
  RxBool isInvalidLatitude = false.obs;
  RxBool isInvalidLongitude = false.obs;
  RxBool isDataComplete = false.obs;

  void setName(String value) {
    name.value = value;
  }

  void setColor(Color value) {
    color.value = value; // Assign Color directly to Rx<Color>
  }

  void setTextSize(double value) {
    textSize.value = value;
  }

  void setLatitude(String value) {
    latitude.value = value;

    if (value.isEmpty || !isLatitudeValid(value)) {
      isInvalidLatitude.value = true;
    } else {
      isInvalidLatitude.value = false;
    }
  }

  void setLongitude(String value) {
    longitude.value = value;

    if (value.isEmpty || !isLongitudeValid(value)) {
      isInvalidLongitude.value = true;
    } else {
      isInvalidLongitude.value = false;
    }
  }

  void checkDataCompletion() {
    if ((!isInvalidLatitude.value) && (!isInvalidLongitude.value)) {
      if ((longitude.value != 0.0) && (latitude.value != 0.0)) {
        Get.snackbar("Please", "Compelete the Profile",
            backgroundColor: Colors.green.shade200);
        isDataComplete.value = true;
      }
    } else {
      isDataComplete.value = false;
    }
  }

  bool isLatitudeValid(String value) {
    final latitudeRegex = RegExp(r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)$');
    return latitudeRegex.hasMatch(value);
  }

  bool isLongitudeValid(String value) {
    final longitudeRegex =
        RegExp(r'^[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$');
    return longitudeRegex.hasMatch(value);
  }

  void toggleColorPicker() {
    showColorPicker.value = !showColorPicker.value;
  }

  Future<void> saveProfile() async {
    if (isDataComplete.value) {
      try {
        final newProfile = DeviceProfile(
          id: 0,
          name: name.value,
          latitude: double.parse(latitude.value),
          longitude: double.parse(longitude.value),
          themeColor: color.value.value.toString(),
          fontSize: textSize.value,
        );

        await database.openDatabase();

        // Get all existing profiles
        final existingProfiles = await database.getAllDeviceProfiles();

        // Compare the new profile with existing profiles
        final repeatedFields = _compareProfiles(newProfile, existingProfiles);

        if (repeatedFields.isEmpty) {
          await database.saveDeviceProfile(newProfile);
          loadDeviceProfiles();
          Get.back();
          isDataComplete.value = false;
          showColorPicker.value = false;
        } else {
          // Show the repeated fields as an error message
          final repeatedFieldsString = repeatedFields.join(', ');
          Get.snackbar(
            'Error',
            'The following fields are repeated: $repeatedFieldsString',
            backgroundColor: Colors.red.shade200,
            colorText: Colors.black,
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      checkDataCompletion();
    }
  }

  List<String> _compareProfiles(
      DeviceProfile newProfile, List<DeviceProfile> existingProfiles) {
    final repeatedFields = <String>[];

    for (final profile in existingProfiles) {
      if (profile.name == newProfile.name) {
        repeatedFields.add('Name');
      }
      if (profile.latitude == newProfile.latitude) {
        repeatedFields.add('Latitude');
      }
      if (profile.longitude == newProfile.longitude) {
        repeatedFields.add('Longitude');
      }
      if (profile.themeColor == newProfile.themeColor) {
        repeatedFields.add('Theme Color');
      }
      if (profile.fontSize == newProfile.fontSize) {
        repeatedFields.add('Font Size');
      }
    }

    return repeatedFields;
  }
}
