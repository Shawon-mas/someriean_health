import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

import '../../../../global/global_constants.dart';
import '../../bottombar_screen.dart';

class CallPage extends StatelessWidget {

  final String callingId;
  const CallPage({Key? key, required this.callingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String localUserID = math.Random().nextInt(10000).toString();
    return SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: 2044973971,
          appSign: '93d80d7df3bedfefacc88274a6f253efeed98c295b75cdf09d5ef56351df338b',
          userID: localUserID,
          userName: "user_$localUserID",
          callID: callingId,
          /*onDispose: (){
            logger.d("Here i go");
            Get.to(() => BottomBarScreen());
          },*/
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            ..onOnlySelfInRoom = (context) {
              logger.d("Here i go");
              Navigator.of(context).pop();
            },
        ),
    );
  }
}
