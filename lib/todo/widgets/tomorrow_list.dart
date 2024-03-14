import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/common/widgets/expansion_tile.dart';
import 'package:task_manager/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/todo/controllers/xpansion_provider.dart';
import 'package:task_manager/todo/pages/update_task.dart';
import 'package:task_manager/todo/widgets/todo_tile.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.watch(todoStateProvider.notifier).getRandomColor();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();
    var tomorrowTasks =
        todos.where((element) => element.date!.contains(tomorrow));

    return XpansionTile(
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
              )
            : const Icon(
                AntDesign.closecircleo,
              ),
      ),
      children: [
        for (final todo in tomorrowTasks)
          TodoTile(
              title: todo.title,
              description: todo.desc,
              color: color,
              start: todo.startTime,
              end: todo.endTime,
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
              },
              editWidget: GestureDetector(
                onTap: () {
                  titles = todo.title.toString();
                  descs = todo.desc.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateTask(id: todo.id ?? 0)));
                },
                child: const Icon(MaterialCommunityIcons.circle_edit_outline),
              ),
              switcher: const SizedBox.shrink()),
      ],
    );
  }
}
