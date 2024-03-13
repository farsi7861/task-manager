import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/common/widgets/expansion_tile.dart';
import 'package:task_manager/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/todo/controllers/xpansion_provider.dart';
import 'package:task_manager/todo/widgets/todo_tile.dart';

class DayAfterTomorrow extends ConsumerWidget {
  const DayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.watch(todoStateProvider.notifier).getRandomColor();
    String dayAfter = ref.read(todoStateProvider.notifier).getDayAfter();
    var tomorrowTasks =
        todos.where((element) => element.date!.contains(dayAfter));

    return XpansionTile(
      text: DateTime.now()
          .add(const Duration(days: 2))
          .toString()
          .substring(5, 10),
      text2: "Day After Tomorrow Tasks",
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
                onTap: () {},
                child: const Icon(MaterialCommunityIcons.circle_edit_outline),
              ),
              switcher: const SizedBox.shrink()),
      ],
    );
  }
}
