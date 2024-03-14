// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/models/task_model.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_text.dart';
import 'package:task_manager/common/widgets/hieght_spacer.dart';
import 'package:task_manager/common/widgets/custom_ont_btn.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:task_manager/todo/controllers/dates/dates_provider.dart';
import 'package:task_manager/todo/controllers/todo/todo_provider.dart';

class UpdateTask extends ConsumerStatefulWidget {
  const UpdateTask({super.key, required this.id});

  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends ConsumerState<UpdateTask> {
  final TextEditingController title = TextEditingController(text: titles);
  final TextEditingController desc = TextEditingController(text: descs);

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var finish = ref.watch(finishTimeStateProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const HieghtSpacer(
                hieght: 20,
              ),
              CustomTextField(
                hintText: "Add Title",
                controller: title,
                hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
              ),
              const HieghtSpacer(
                hieght: 20,
              ),
              CustomTextField(
                hintText: "Add Description",
                controller: desc,
                hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
              ),
              const HieghtSpacer(
                hieght: 20,
              ),
              CustomOtlnBtn(
                onTap: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2024, 3, 10),
                      maxTime: DateTime(2025, 3, 10),
                      theme: const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppConst.kGreen, fontSize: 16)),
                      onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString());
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kBlueLight,
                text: scheduleDate == ""
                    ? "Set Date"
                    : scheduleDate.substring(0, 10),
              ),
              const HieghtSpacer(hieght: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOtlnBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: start == "" ? "Start Time" : start.substring(10, 16),
                  ),
                  CustomOtlnBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text:
                        finish == "" ? "Finish Time" : finish.substring(10, 16),
                  ),
                ],
              ),
              const HieghtSpacer(hieght: 20),
              CustomOtlnBtn(
                onTap: () {
                  if (title.text.isNotEmpty &&
                      desc.text.isNotEmpty &&
                      scheduleDate.isNotEmpty &&
                      start.isNotEmpty &&
                      finish.isNotEmpty) {
                    Task task = Task(
                        title: title.text,
                        desc: desc.text,
                        isCompleted: 0,
                        date: scheduleDate,
                        startTime: start.substring(10, 16),
                        endTime: finish.substring(10, 16),
                        remind: 0,
                        repeat: "yes");
                    ref.read(todoStateProvider.notifier).addItem(task);
                    ref.read(finishTimeStateProvider.notifier).setStart('');
                    ref.read(startTimeStateProvider.notifier).setStart('');
                    ref.read(dateStateProvider.notifier).setDate('');
                    Navigator.pop(context);
                  } else {
                    print("failed to add task");
                  }
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kGreen,
                text: "Submit",
              ),
            ],
          ),
        ));
  }
}
