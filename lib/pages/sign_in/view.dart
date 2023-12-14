// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unnecessary_import

import 'package:firebase_chat/common/widgets/button.dart';
import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../common/values/colors.dart';
import '../../common/values/shadows.dart';
import 'controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildThirdPartyLogin() {
      return Container(
        width: 295.w,
        margin: EdgeInsets.only(bottom: 280.h),
        child: Column(children: [
          Text(
            "Sign in with Social Networks",
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40.h, left: 50.w, right: 50.w),
            child: btnFlatButtonWidget(
              onPressed: () {
                controller.handleSingIn();
              },
              width: 295.w,
              height: 44.h,
              title: "Sign in with Google",
            ),
          ),
        ]),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Spacer(),
            _buildThirdPartyLogin()
          ],
        ),
      ),
    );
  }
}
