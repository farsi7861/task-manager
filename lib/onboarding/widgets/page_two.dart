import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/auth/pages/login.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_ont_btn.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHieght,
      width: AppConst.kWidth,
      color: AppConst.kBkDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 350,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(children: [
              const Icon(
                Icons.add_task_outlined,
                size: 90,
                color: AppConst.kLight,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Task Manager",
                style: appstyle(30, AppConst.kLight, FontWeight.w500),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomOtlnBtn(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  width: AppConst.kWidth * 0.9,
                  height: AppConst.kHieght * 0.06,
                  color: AppConst.kLight,
                  text: "Login with phone number")
            ]),
          ),
        ],
      ),
    );
  }
}
