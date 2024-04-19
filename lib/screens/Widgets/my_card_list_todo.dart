// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shtodo/provider/service_provider.dart';

class CardListTodo extends ConsumerWidget {
  final int getIndex;
  const CardListTodo({
    super.key,
    required this.getIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data: (todoData) {
        Color getColor = Color(0xFF0C7C99);
        final getCategory = todoData[getIndex].category;

        switch (getCategory) {
          case 'Learning':
            getColor = Color(0xFF0C7C99);
            break;
          case 'Work':
            getColor = Color.fromARGB(255, 229, 23, 244);
            break;
          case 'General':
            getColor = Colors.green;
            break;
        }

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                decoration: BoxDecoration(
                  color: getColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.delete),
                          onPressed: () => ref.read(serviceProvider).deleteTask(
                                todoData[getIndex].docId,
                              ),
                        ),
                        title: Text(
                          todoData[getIndex].titleTask,
                          style: TextStyle(
                            fontFamily: "kurdish",
                            fontSize: 16,
                            decoration: todoData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          todoData[getIndex].description,
                          style: TextStyle(
                            fontFamily: "kurdish",
                            fontSize: 14,
                            decoration: todoData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: todoData[getIndex].isDone,
                              onChanged: (value) {
                                if (todoData != null &&
                                    todoData.length > getIndex) {
                                  final String? docId =
                                      todoData[getIndex]?.docId;
                                  final bool valueNotNull = value ??
                                      false; // ? Default to false if value is null

                                  if (docId != null) {
                                    ref
                                        .read(serviceProvider)
                                        .updateTask(docId, valueNotNull);
                                    print(
                                        'Document with ID $docId updated successfully.');
                                  } else {
                                    print('Error: Document ID is null.');
                                  }
                                } else {
                                  print(
                                      'Error: Invalid todoData or insufficient elements.');
                                }
                              },
                            )),
                      ),
                      Transform.translate(
                        offset: Offset(0, -10),
                        child: Container(
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'کات',
                                    style: TextStyle(
                                      fontFamily: "kurdish",
                                      fontSize: 14,
                                    ),
                                  ),
                                  Gap(10),
                                  Text(
                                    todoData[getIndex].dateTask,
                                    style: TextStyle(
                                      fontFamily: "english",
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, StackTrace) => Center(
        child: Text(StackTrace.toString()),
      ),
      loading: (() => const Center(child: CircularProgressIndicator())),
    );
  }
}
