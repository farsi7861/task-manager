import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/hieght_spacer.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            HieghtSpacer(hieght: AppConst.kHieght * 0.12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Icon(
                Icons.verified_user_outlined,
                size: 100,
                color: AppConst.kLight,
              ),
            ),
            const HieghtSpacer(hieght: 26),
            Text(
              "Enter your OTP",
              style: appstyle(20, AppConst.kLight, FontWeight.w400),
            ),
            const HieghtSpacer(hieght: 30),
            Pinput(
              length: 6,
              showCursor: true,
              onCompleted: (value) {
                if (value.length == 6) {}
              },
              onSubmitted: (value) {
                if (value.length == 6) {}
              },
            ),
          ]),
        ),
      ),
    );
  }
}
