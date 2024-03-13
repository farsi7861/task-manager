import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_text.dart';
import 'package:task_manager/common/widgets/expansion_tile.dart';
import 'package:task_manager/common/widgets/hieght_spacer.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';
import 'package:task_manager/common/widgets/width_spacer.dart';
import 'package:task_manager/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/todo/controllers/xpansion_provider.dart';
import 'package:task_manager/todo/pages/add.dart';
import 'package:task_manager/todo/widgets/today_task.dart';
import 'package:task_manager/todo/widgets/todo_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Dashboard",
                      style: appstyle(18, AppConst.kLight, FontWeight.bold),
                    ),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: const BoxDecoration(
                        color: AppConst.kLight,
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddTask()));
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppConst.kBkDark,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const HieghtSpacer(hieght: 20),
              CustomTextField(
                hintText: "Search",
                controller: search,
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      AntDesign.search1,
                      color: AppConst.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: AppConst.kGreyLight,
                ),
              ),
              const HieghtSpacer(hieght: 15)
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const HieghtSpacer(hieght: 25),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: AppConst.kLight,
                  ),
                  const WidthSpacer(wydth: 10),
                  ReusableText(
                    text: "Today's Task",
                    style: appstyle(18, AppConst.kLight, FontWeight.bold),
                  )
                ],
              ),
              const HieghtSpacer(hieght: 25),
              Container(
                decoration: BoxDecoration(
                  color: AppConst.kLight,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConst.kRadius),
                  ),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppConst.kRadius),
                    ),
                  ),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: AppConst.kBlueLight,
                  unselectedLabelColor: AppConst.kLight,
                  labelStyle:
                      appstyle(24, AppConst.kBlueLight, FontWeight.w700),
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: AppConst.kWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: "Pending",
                            style:
                                appstyle(16, AppConst.kBkDark, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        width: AppConst.kWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: "Completed",
                            style:
                                appstyle(16, AppConst.kBkDark, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HieghtSpacer(hieght: 20),
              SizedBox(
                height: AppConst.kHieght * 0.3,
                width: AppConst.kWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConst.kRadius),
                  ),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                          color: AppConst.kBkLight,
                          height: AppConst.kHieght * 0.3,
                          child: const TodayTask()),
                      Container(
                        color: AppConst.kBkLight,
                        height: AppConst.kHieght * 0.3,
                      )
                    ],
                  ),
                ),
              ),
              const HieghtSpacer(hieght: 20),
              XpansionTile(
                text: "Tomorrow's Task",
                text2: "Tomorrow's task are shown here",
                onExpansionChanged: (bool expanded) {
                  ref.read(xpansionStateProvider.notifier).setStart(!expanded);
                },
                trailing: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: ref.watch(xpansionStateProvider)
                      ? const Icon(
                          AntDesign.circledown,
                          color: AppConst.kLight,
                        )
                      : const Icon(AntDesign.closecircleo,
                          color: AppConst.kBlueLight),
                ),
                children: [
                  TodoTile(
                    start: "03:00",
                    end: "05:00",
                    switcher: Switch(value: true, onChanged: (value) {}),
                  ),
                ],
              ),
              const HieghtSpacer(hieght: 20),
              XpansionTile(
                text: DateTime.now()
                    .add(const Duration(days: 2))
                    .toString()
                    .substring(5, 10),
                text2: "Tomorrow's task are shown here",
                onExpansionChanged: (bool expanded) {
                  ref.read(xpansionState0Provider.notifier).setStart(!expanded);
                },
                trailing: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: ref.watch(xpansionState0Provider)
                      ? const Icon(
                          AntDesign.circledown,
                          color: AppConst.kLight,
                        )
                      : const Icon(AntDesign.closecircleo,
                          color: AppConst.kBlueLight),
                ),
                children: [
                  TodoTile(
                    start: "03:00",
                    end: "05:00",
                    switcher: Switch(value: true, onChanged: (value) {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
