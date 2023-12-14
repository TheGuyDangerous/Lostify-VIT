// ignore: depend_on_referenced_packages
import 'package:firebase_chat/pages/contact/controller.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/pages/sign_in/controller.dart';
import '../homepage/controller.dart';
import '../message/controller.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<MessageController>(() => MessageController());

  }
}