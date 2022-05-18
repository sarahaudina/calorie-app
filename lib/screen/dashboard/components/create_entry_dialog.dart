import 'package:calorie_mobile/config/config.dart';
import 'package:calorie_mobile/movas/actions/entry_action.dart';
import 'package:calorie_mobile/movas/models/entry.dart';
import 'package:calorie_mobile/screen/dashboard/components/material_text_field.dart';
import 'package:flutter/material.dart';

Future<void> createEntryDialog(
    BuildContext context ) async {
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController totalCaloriesController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add Entry"),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MaterialTextField(
                  label: "Food Name",
                  hint: "What did you eat",
                  controller: foodNameController,
                ),
                MaterialTextField(
                  label: "Total Calories",
                  hint: "Total Calories",
                  controller: totalCaloriesController,
                ),
                MaterialTextField(
                  label: "Price (USD)",
                  hint: "Price",
                  controller: priceController,
                ),
                InkWell(
                  onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 100)),
                      lastDate: DateTime.now().add(Duration(days: 0)))
                    .then((value) => datePickerController.text = value.toString()),
                  child: MaterialTextField(
                    label: "Date",
                    hint: "Eat Date",
                    disable: true,
                    controller: datePickerController,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('CREATE'),
            onPressed: () {
              // show loading for 2 secs
              EntryAction.of(context).createEntry(
                  FoodEntry(
                      foodNameController.text,
                      null,
                      double.parse(totalCaloriesController.text),
                      double.parse(priceController.text),
                      user_id,
                      DateTime.parse(datePickerController.text)));
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}