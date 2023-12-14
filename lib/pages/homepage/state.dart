import 'package:get/get.dart';
import 'package:firebase_chat/common/entities/user.dart';

class HomePageState {
  var count = 0.obs;
  RxList<UserData> contactList = <UserData>[].obs;
}
