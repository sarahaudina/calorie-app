import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/movas/models/entry.dart';
import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/screen/shared_components/material_text_field.dart';
import 'package:calorie/screen/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


Future<void> createEntryDialog(
    BuildContext context, {EntryO? existingEntry} ) async {
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController totalCaloriesController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  DateTime initialDate = DateTime.now();

  if (existingEntry!=null) {
    initialDate = existingEntry.createdAt;
    foodNameController.text = existingEntry.name;
    totalCaloriesController.text = existingEntry.calories.toString();
    priceController.text = existingEntry.price?.toString() ?? "";
    userIdController.text = existingEntry.userId;
  }

  datePickerController.text=Util.formatDate(initialDate);


  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add Entry"),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MaterialTextField(
                  label: "User Id",
                  hint: "User Id",
                  controller: userIdController,
                  disable: existingEntry!=null,
                ),
                MaterialTextField(
                  label: "Food Name",
                  hint: "What did you eat?",
                  controller: foodNameController,
                ),
                MaterialTextField(
                  suffix: ' cal',
                  keyboardType: TextInputType.number,
                  label: "Total Calories",
                  hint: "Total Calories",
                  controller: totalCaloriesController,
                ),
                MaterialTextField(
                  keyboardType: TextInputType.number,
                  prefix: 'USD ',
                  label: "Price (USD)",
                  hint: "Price",
                  controller: priceController,
                ),
                InkWell(
                  onTap: () => showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime.now().subtract(Duration(days: 100)),
                      lastDate: DateTime.now().add(Duration(days: 0)))
                    .then((value) {
                      if (value!=null)
                        datePickerController.text = Util.formatDate(value);
                  }),
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
            child: Text(existingEntry!=null ? 'UPDATE' : 'CREATE'),
            onPressed: () {
              existingEntry!=null ?
                  EntryAction.of(context).updateEntry(
                      existingEntry.id,
                      foodNameController.text,
                      double.parse(totalCaloriesController.text),
                      priceController.text=="" ? null : double.parse(priceController.text),
                      userIdController.text,
                      Util.parseDate(datePickerController.text))
              : EntryAction.of(context).createEntry(
                  FoodEntry(
                      foodNameController.text,
                      null,
                      double.parse(totalCaloriesController.text),
                      priceController.text=="" ? null : double.parse(priceController.text),
                      userIdController.text,
                      Util.parseDate(datePickerController.text)));
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}