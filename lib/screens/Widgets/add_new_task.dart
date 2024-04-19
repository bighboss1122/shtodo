// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, unused_import, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shtodo/constants/app_style.dart';
import 'package:shtodo/model/todo_model.dart';
import 'package:shtodo/provider/date_time_provider.dart';
import 'package:shtodo/provider/radio_provider.dart';
import 'package:shtodo/provider/service_provider.dart';
import 'package:shtodo/screens/Widgets/my_button.dart';
import 'package:shtodo/screens/Widgets/my_date_time.dart';
import 'package:shtodo/screens/Widgets/my_radio.dart';
import 'package:shtodo/screens/Widgets/text_field.dart';

class AddNewTask extends ConsumerWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  AddNewTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datePro = ref.watch(dateProvider);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.84,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Gap(25),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ئەرکە نوێیەکان",
                      style: TextStyle(
                        fontFamily: "kurdish",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(15),
              Divider(
                thickness: 0.5,
                color: Colors.grey.shade400,
              ),
              Gap(15),
              Text(
                "ناوی ئەرک",
                style: AppStyle.headingTitle,
              ),
              Gap(10),
              TextFieldWidget(
                controller: titleController,
                hintText: "ناوی ئەرکەکە بنوسە..",
                maxLine: 1,
              ),
              Gap(15),
              Text(
                "دەربارەی ئەرک",
                style: AppStyle.headingTitle,
              ),
              Gap(15),
              TextFieldWidget(
                controller: descriptionController,
                hintText: "دەربارەی ئەرکەکە بنوسە..",
                maxLine: 3,
              ),
              Gap(20),
              Text(
                "کاتیگۆری (جۆر)",
                style: AppStyle.headingTitle,
              ),
              Gap(10),
              // ? radio button bo categoryakan
              Row(
                children: [
                  Expanded(
                    child: MyRadio(
                      titleRadio: "Learning",
                      categroyColor: Color(0xFF0C7C99),
                      values: 1,
                      onChangedValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 1),
                    ),
                  ),
                  Expanded(
                    child: MyRadio(
                      titleRadio: "Work",
                      categroyColor: Color.fromARGB(255, 5, 28, 203),
                      values: 2,
                      onChangedValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 2),
                    ),
                  ),
                  Expanded(
                    child: MyRadio(
                      titleRadio: "General",
                      categroyColor: Colors.green,
                      values: 3,
                      onChangedValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 3),
                    ),
                  ),
                ],
              ),

              // ? bashy kat w barwar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDateTime(
                    titleText: "کات",
                    valeuText: ref.watch(timeProvider),
                    icon: CupertinoIcons.time,
                    onTap: () async {
                      final getTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (getTime != null) {
                        ref
                            .read(timeProvider.notifier)
                            .update((state) => getTime.format(context));
                      }
                    },
                  ),
                  Gap(20),
                  MyDateTime(
                    titleText: "بەروار",
                    valeuText: datePro,
                    icon: CupertinoIcons.calendar,
                    onTap: () async {
                      final getValue = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2500),
                        initialDate: DateTime.now(),
                      );
                      if (getValue != null) {
                        final format =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        ref
                            .read(dateProvider.notifier)
                            .update((state) => format.toString());
                      }
                    },
                  ),
                ],
              ),
              // ? bashy hallbzhardakan bo zyadkrdn yaxud ratkrdnawa
              Gap(25),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      btnName: 'زیادکردن',
                      onTap: () {
                        final getRadioValues = ref.read(radioProvider);
                        String category = '';
                        switch (getRadioValues) {
                          case 1:
                            category = 'Learning';
                            break;
                          case 2:
                            category = 'Work';
                            break;
                          case 3:
                            category = 'General';
                            break;
                        }

                        ref.read(serviceProvider).addNewTask(
                              TodoModel(
                                titleTask: titleController.text,
                                description: descriptionController.text,
                                category: category,
                                dateTask: ref.read(dateProvider),
                                timeTask: ref.read(timeProvider),
                                isDone: false,
                              ),
                            );
                        titleController.clear();
                        descriptionController.clear();
                        ref.read(radioProvider.notifier).update((state) => 0);
                        Navigator.pop(context);
                      },
                      fontFamily: "kurdish",
                      fontSizes: 19,
                      textColor: Colors.white,
                      btnColor: Color(0xFF0C7C99),
                    ),
                  ),
                ],
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      btnName: 'ڕەتکردنەوە',
                      onTap: () => Navigator.pop(context),
                      fontFamily: "kurdish",
                      fontSizes: 19,
                      textColor: Colors.white,
                      btnColor: const Color.fromARGB(255, 199, 2, 22),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
