import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/services/database.dart';
import 'package:weight_tracker/utils/miscFunctions.dart';
import 'package:weight_tracker/utils/strings.dart';

Future<void> displayEditWeightDialog(
    BuildContext context,
    String userId,
    String weightId,
    TextEditingController textFieldController,
    GlobalKey<FormState> key) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(edit),
          content: Form(
            key: key,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: textFieldController,
              decoration: InputDecoration(hintText: newWeightTextFieldHint),
              validator: (value) {
                if (value.isEmpty) {
                  return emptyFieldError;
                }
                if (!isNumeric(value)) return (numbersOnlyError);
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                if (key.currentState.validate()) {
                  await DatabaseService()
                      .editWeight(weightId, userId, textFieldController.text);
                  textFieldController.clear();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      });
}
