import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'custom_colors.dart';

class LargeButton extends StatelessWidget{
  final String task;
  final bool isCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  LargeButton({
    super.key,
    required this.task,
    required this.isCompleted,
    required this.onChanged,
    required this.deleteTask
  });

  @override
  Widget build(BuildContext context) {
    return
      //bouton
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteTask,
                icon: Icons.delete_sweep_rounded,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(10),
                padding: const EdgeInsets.only(bottom: 10),
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: CustomColors.primaryColorFade,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isCompleted,
                      activeColor: Colors.purpleAccent,
                      checkColor: Colors.white,
                      visualDensity: VisualDensity.compact,
                      onChanged: onChanged,
                    ),

                    const SizedBox(width: 8),
                    SizedBox(
                      width: 200, // set a maximum width for the text
                      child: Text(
                        task,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,

                            decoration:
                            isCompleted ? TextDecoration.lineThrough : TextDecoration.none
                        ),
                        overflow: TextOverflow.fade, // use ellipsis to truncate text
                      ),
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