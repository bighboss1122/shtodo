import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shtodo/provider/service_provider.dart';
import 'package:shtodo/screens/Widgets/add_new_task.dart';
import 'package:shtodo/screens/Widgets/my_button.dart';
import 'package:shtodo/screens/Widgets/my_card_list_todo.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    if (todoData.value == null) {
      return CircularProgressIndicator();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Image.asset('assets/images/fam.png'),
            ),
            title: Text(
              'سڵاو من',
              style: TextStyle(
                fontFamily: "kurdish",
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
            subtitle: Text(
              'شەهرام عوسمان',
              style: TextStyle(
                fontFamily: "kurdish",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () {
                        // Show the CalendarDatePicker
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.calendar,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.bell,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ئەرکی ئەمڕۆ',
                        style: TextStyle(
                          fontFamily: "kurdish",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        style: TextStyle(
                          fontFamily: "kurdish",
                        ),
                      ),
                    ],
                  ),
                  MyButton(
                    btnName: '+ ئەرکی نوێ',
                    onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return AddNewTask();
                      },
                    ),
                    fontFamily: 'kurdish',
                    fontSizes: 17,
                    textColor: Colors.white,
                    btnColor: Color(0xFF0C7C99),
                  ),
                ],
              ),
              Gap(15),
              // Check if todoData.value is not null and not empty before accessing its length property
              if (todoData.value!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: todoData.value!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CardListTodo(
                      getIndex: index,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
