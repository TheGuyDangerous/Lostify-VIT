// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unnecessary_import

import 'package:firebase_chat/common/widgets/button.dart';
import 'package:firebase_chat/pages/homepage/models/product.dart';
import 'package:firebase_chat/pages/homepage/models/shop.dart';
import 'package:firebase_chat/pages/homepage/widgets/posts.dart';
import 'package:firebase_chat/pages/homepage/widgets/product_tile.dart';
import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/values/colors.dart';
import '../../common/values/shadows.dart';
import 'controller.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({Key? key}) : super(key: key);

  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('User Posts').add({
        'Message': textController.text,
        'UserEmail': currentUser.email,
        'TimeStamp': Timestamp.now(),
      });
      textController.clear();
    }
  }

  setState() {
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().shop;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Adjust the height as needed
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: AppColors.inversePrimary,
          title: Padding(
            padding: EdgeInsets.only(top: 30.0), // Add space to the top
            child: Text(
              'Lostify VIT',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Post your missing item...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: postMessage,
                icon: const Icon(Icons.arrow_circle_up),
                color: AppColors.inversePrimary,
                iconSize: 30.sp,
              ),
            ],
          ),
          const SizedBox(height: 25),
          Center(
              child: Text(
            'Pick from a selected list of lost items',
            style: TextStyle(color: AppColors.inversePrimary),
          )),
          SizedBox(
            height: 450,
            child: ListView.builder(
                scrollDirection: Axis
                    .horizontal, // Add space to the top // Add space to the top
                padding: EdgeInsets.all(15),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductTile(product: product);
                }),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Posts from other users',
              style:
                  TextStyle(color: AppColors.inversePrimary, fontSize: 15.sp),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User Posts')
                .orderBy('TimeStamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final posts = snapshot.data!.docs;
                List<WallPost> postWidgets = [];
                for (var post in posts) {
                  final message = post.get('Message');
                  final user = post.get('UserEmail');
                  final time = post.get('TimeStamp');
                  final postWidget = WallPost(
                    message: message,
                    user: user,
                    time: time.toString(),
                  );
                  postWidgets.add(postWidget);
                }
                return Column(
                  children: postWidgets,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
