import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/common/widgets/toast.dart';
import 'package:firebase_chat/pages/sign_in/state.dart';
import 'package:get/get.dart';
import '../../common/store/user.dart';
import 'index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePageController extends GetxController {
  final state = HomePageState();
  HomePageController();
  final db = FirebaseFirestore.instance;

  get products => null;

  @override
  void onReady() {
    super.onReady();
  }
}
