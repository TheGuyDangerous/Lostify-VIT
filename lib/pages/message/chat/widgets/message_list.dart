import 'package:firebase_chat/common/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common/entities/msg.dart';
import '../../controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';


class MessageList extends GetView<MessageController> {
  const MessageList({super.key});

  Widget messageListItem(QueryDocumentSnapshot<Msg> item){
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
      child: InkWell(
        onTap: () {
          var to_uid="";
          var to_name="";
          var to_avatar="";
          if (item.data().from_uid==controller.token){
            to_uid=item.data().to_uid??"";
            to_name=item.data().to_name??"";
            to_avatar=item.data().to_avatar??"";
          }else{
            to_uid=item.data().from_uid??"";
            to_name=item.data().from_name??"";
            to_avatar=item.data().from_avatar??"";
          }
          Get.toNamed("/chat",parameters: {
            "doc_id":item.id,
            "to_uid":to_uid,
            "to_name":to_name,
            "to_avatar":to_avatar,
          });
        },

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 15.w),
              child: SizedBox(
                width: 54.w,
                height: 54.w,
                child: CachedNetworkImage(
                  imageUrl: item.data().from_uid==controller.token
                      ?item.data().to_avatar!:
                       item.data().from_avatar!,
                  imageBuilder: (contect, imageProvider) => Container(
                    width: 54.w,
                    height: 54.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(54.w),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                ),
                  errorWidget: (context, url, error) => const Image(
                    image: AssetImage('assets/images/feature-1.png'),
                  ),
              ),
            )),
            Container(
              padding: EdgeInsets.only(top: 5.h, left: 0.w, right: 5.w,bottom: 5.h),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color:  Color(0xffe5e5e5),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 40.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.data().from_uid==controller.token
                              ?item.data().to_name!:
                          item.data().from_name!,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xff333333),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          item.data().last_msg??"",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xff333333),
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                    height: 54.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          duTimeLineFormat(
                            (item.data().last_time as Timestamp).toDate(),
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff999999),
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var item = controller.state.msgList[index];
                      return messageListItem(item);
                    },
                    childCount: controller.state.msgList.length,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
