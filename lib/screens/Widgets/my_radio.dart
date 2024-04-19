// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shtodo/provider/radio_provider.dart';

class MyRadio extends ConsumerWidget {
  final String titleRadio;
  final Color categroyColor;
  final int values;
  final VoidCallback onChangedValue;
  const MyRadio({
    super.key,
    required this.titleRadio,
    required this.values,
    required this.onChangedValue,
    required this.categroyColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: categroyColor,
          ),
          child: RadioListTile(
            activeColor: categroyColor,
            contentPadding: EdgeInsets.zero,
            title: Transform.translate(
              offset: Offset(15, 0),
              child: Text(
                titleRadio,
                style: TextStyle(
                  fontFamily: "kurdish",
                  color: categroyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            value: values,
            groupValue: radio,
            onChanged: (value) => onChangedValue(),
          ),
        ),
      ),
    );
  }
}
