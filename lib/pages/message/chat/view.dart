// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unnecessary_import

import 'package:firebase_chat/pages/message/chat/widgets/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../common/values/colors.dart';
import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.inversePrimary,
      title: Container(
          padding: EdgeInsets.only(top: 5.w, bottom: 15.w, right: 0.w),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10.w, bottom: 0.w, right: 0.w),
                  child: InkWell(
                      child: SizedBox(
                          width: 44.w,
                          height: 44.w,
                          child: CachedNetworkImage(
                            imageUrl: controller.state.to_avatar.value,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 44.w,
                              width: 44.w,
                              margin: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(44.w),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image(
                              image: AssetImage("assets/images/feature-1.png"),
                            ),
                          )))),
              SizedBox(
                width: 15.w,
              ),
              Container(
                  width: 180.w,
                  padding: EdgeInsets.only(top: 10.w, bottom: 0.w, right: 0.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 180.w,
                          height: 42.w,
                          child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.state.to_name.value,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.inversePrimary,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Text(
                                    "Unknown Location",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.inversePrimary,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              )))
                    ],
                  ))
            ],
          )),
    );
  }
  void _showPicker(context){
    showModalBottomSheet(
        context: context, builder: (BuildContext bc){
      return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: (){
                  controller.imgFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Camera"),
                onTap: (){

                },
              )
            ],
          ));
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: [
                ChatList(),
                Positioned(
                  bottom: 0.h,
                  height: 50.h,
                  child: Container(
                    width: 360.w,
                    height: 50.h,
                    color: AppColors.primaryBackground,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 217.w,
                          height: 50.h,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              controller: controller.textController,
                              autofocus: false,
                              focusNode: controller.contentNode,
                              decoration: InputDecoration(
                                hintText: "Type a message ...",
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 30.h,
                            width: 30.w,
                            margin: EdgeInsets.only(left: 15.w, top: 5.h),
                            child: GestureDetector(
                              child: Icon(
                                Icons.arrow_circle_up, // Icons.camera_alt,
                                size: 25.sp,
                                color: AppColors.inversePrimary,
                              ),
                              onTap: () {
                                _showPicker(context);
                              },
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 0.w, top: 5.h, right: 6.w),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                            ),
                            onPressed: () {
                              controller.sendMessage();
                            },
                            child: Icon(Icons.send_rounded,
                                size: 20.sp, color: AppColors.inversePrimary),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
