import 'package:challenge148/controller/common_controller.dart';
import 'package:challenge148/screen/new_profile.dart';
import 'package:challenge148/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CommonController commonController = Get.put(CommonController());

  @override
  void initState() {
    super.initState();
    // Load device profiles when the screen initializes
    commonController.loadDeviceProfiles();
  }

  @override
  void dispose() {
    commonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .primaryColor, // Set the background color based on selectedProfile
      body: SafeArea(
        bottom: false,
        child: GetBuilder<CommonController>(
          init: commonController,
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hii,\nWelcome!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => NewProfileScreen(),
                            duration: Duration(seconds: 1),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade700,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: controller.deviceProfiles.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.deviceProfiles.length,
                          itemBuilder: (context, index) {
                            var data = controller.deviceProfiles[index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onDoubleTap: () {
                                  controller.deleteDeviceProfiles(data.id);
                                  controller.loadDeviceProfiles();
                                },
                                onTap: () {
                                  Get.to(
                                    () => ProfileScreen(
                                      fontSize: data.fontSize,
                                      name: data.name,
                                      themeColor: data.themeColor,
                                      latitude: data.latitude,
                                      longitude: data.longitude,
                                      id: data.id,
                                    ),
                                    duration: Duration(seconds: 1),
                                    transition: Transition.circularReveal,
                                  );
                                },
                                child: Container(
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blueGrey.shade700,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Location Name: ${data.name}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: data.fontSize,
                                          ),
                                        ),
                                        Text(
                                          "Coordinates: ${data.latitude}, ${data.longitude}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: data.fontSize,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Colour:",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: data.fontSize,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              width: 40.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: Colors
                                                        .blueGrey.shade900),
                                                color: Color(
                                                    int.parse(data.themeColor)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade700,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 60,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Get.to(
                                  () => NewProfileScreen(),
                                  duration: Duration(seconds: 1),
                                  transition: Transition.circularReveal,
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
