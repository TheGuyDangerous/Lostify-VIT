import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/pages/message/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/entities/msg.dart';

class MessageController extends GetxController {
  MessageController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  final MessageState state = MessageState();
  var listener;

  final RefreshController refreshController = RefreshController(
      initialRefresh: true,
      );

  void onRefresh() {
    asyncLoadAllData().then((_){
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((error){
      refreshController.refreshFailed();
    });
  }

  void onLoading() {
    asyncLoadAllData().then((_){
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((error){
      refreshController.refreshFailed();
    });
  }

  asyncLoadAllData() async {
    var from_messages= await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options)=>msg.toFirestore()).where(
      "from_uid", isEqualTo: token
    ).get();

    var to_messages= await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options)=>msg.toFirestore()).where(
        "to_uid", isEqualTo: token
    ).get();
    state.msgList.clear();
    if(from_messages.docs.isNotEmpty){
      state.msgList.assignAll(from_messages.docs);
    }

    if(to_messages.docs.isNotEmpty){
      state.msgList.assignAll(to_messages.docs);
    }
  }
}