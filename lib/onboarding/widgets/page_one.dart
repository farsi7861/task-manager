import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/common/widgets/appstyle.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

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
              const Text(
                  "Welcome!! Do you want ot create a task fast and with ease",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppConst.kGreyLight,
                      fontStyle: FontStyle.italic))
            ]),
          )
        ],
      ),
    );
  }
}
