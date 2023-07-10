import 'package:action_slider/action_slider.dart';
import 'package:challenge148/controller/common_controller.dart';
import 'package:challenge148/model/device_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final int id;
  final String name;
  final double fontSize;
  final String themeColor;
  final double latitude;
  final double longitude;

  const ProfileScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.fontSize,
    required this.themeColor,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse(themeColor)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade700,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Name:',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Theme Color:',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blueGrey.shade900),
                  color: Color(int.parse(themeColor)),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Font Size:',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '${fontSize.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Latitude:',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                latitude.toString(),
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Longitude:',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                longitude.toString(),
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              GetBuilder<CommonController>(
                init: CommonController(),
                initState: (_) {},
                builder: (_) {
                  return ActionSlider.standard(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                    loadingIcon: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    successIcon: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                    ),
                    toggleColor: Colors.blueGrey.shade900,
                    backgroundColor: Colors.blueGrey.shade700,
                    width: Get.width * 0.8,
                    actionThresholdType: ThresholdType.release,
                    child: const Text(
                      'Slide to save',
                      style: TextStyle(color: Colors.white),
                    ),
                    action: (cont) async {
                      cont.loading(); //starts loading animation
                      await Future.delayed(const Duration(seconds: 3));
                      cont.success(); //starts success animation
                      _.setSelectedProfile(DeviceProfile(
                        fontSize: fontSize,
                        id: id,
                        latitude: latitude,
                        longitude: longitude,
                        name: name,
                        themeColor: themeColor,
                      ));
                      await Future.delayed(const Duration(seconds: 1));
                      cont.reset(); //resets the slider
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
