import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/models/task_model.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/todo/widgets/todo_tile.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).last30Days();
    var completedList = listData
        .where((element) =>
            element.isCompleted == 1 ||
            lastMonth.contains(element.date!.substring(0, 10)))
        .toList();
    return ListView.builder(
        itemCount: completedList.length,
        itemBuilder: (context, index) {
          final data = completedList[index];
          dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
          return TodoTile(
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
              },
              editWidget: const SizedBox.shrink(),
              title: data.title,
              description: data.desc,
              start: data.startTime,
              end: data.endTime,
              color: color,
              switcher: const Icon(
                AntDesign.checkcircle,
                color: AppConst.kGreen,
              ));
        });
  }
}
