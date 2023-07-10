import 'package:action_slider/action_slider.dart';
import 'package:challenge148/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NewProfileScreen extends StatelessWidget {
  final CommonController controller = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        child: InkWell(
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
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Add The Data",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                controller.isDataComplete.value
                    ? TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          controller.setName(value);
                        },
                      )
                    : Container(),
                controller.isDataComplete.value
                    ? const SizedBox(height: 16.0)
                    : Container(),
                controller.isDataComplete.value
                    ? Row(
                        children: [
                          const Text(
                            'Color:',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              color: controller.color.value,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            onPressed: () {
                              controller.toggleColorPicker();
                            },
                            icon: const Icon(
                              Icons.color_lens,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                controller.isDataComplete.value
                    ? const SizedBox(height: 10.0)
                    : Container(),
                controller.showColorPicker.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          colorContainer(Colors.blue),
                          colorContainer(Colors.yellow),
                          colorContainer(Colors.grey),
                          colorContainer(Colors.green),
                        ],
                      )
                    : Container(),
                controller.isDataComplete.value
                    ? const SizedBox(height: 16.0)
                    : Container(),
                controller.isDataComplete.value
                    ? Text(
                        'Text Size: ${controller.textSize.toInt()}',
                        style: TextStyle(
                            fontSize: controller.textSize.value,
                            color: Colors.white),
                      )
                    : Container(),
                controller.isDataComplete.value
                    ? Slider(
                        value: controller.textSize.value,
                        min: 10.0,
                        max: 30.0,
                        onChanged: (value) {
                          controller.setTextSize(value);
                        },
                      )
                    : Container(),
                controller.isDataComplete.value
                    ? const SizedBox(height: 16.0)
                    : Container(),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[-+]?(\d+|\d+\.\d*)$'),
                    ),
                  ],
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    controller.setLatitude(value);
                  },
                ),
                if (controller.isInvalidLatitude.value)
                  Text(
                    "Invalid Latitude",
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[-+]?(\d+|\d+\.\d*)$'),
                    ),
                  ],
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    controller.setLongitude(value);
                  },
                ),
                if (controller.isInvalidLongitude.value)
                  Text(
                    "Invalid Longitude",
                    style: TextStyle(color: Colors.red),
                  ),
                Spacer(),
                ActionSlider.standard(
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
                    controller.saveProfile();
                    await Future.delayed(const Duration(seconds: 1));
                    cont.reset(); //resets the slider
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorContainer(Color color) {
    return InkWell(
      onTap: () {
        controller.setColor(color);
      },
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
