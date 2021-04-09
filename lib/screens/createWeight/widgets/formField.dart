import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/utils/miscFunctions.dart';
import 'package:weight_tracker/utils/sizeConfig.dart';
import 'package:weight_tracker/utils/strings.dart';
import 'package:weight_tracker/utils/styles.dart';

class NewSessionFormField extends StatelessWidget {
  final TextEditingController fieldController;

  NewSessionFormField({this.fieldController});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 5,
          ),
          child: TextFormField(
            style: TextStyle(color: Colors.grey[600]),
            controller: fieldController,
            validator: (value) {
              if (value.isEmpty) {
                return emptyFieldError;
              }
              if (!isNumeric(value)) return (numbersOnlyError);
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: AddWeightScreenStyles()
                .inputFieldStyle(labelText: addWeightFormFieldPlaceholder),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 6,
        ),
      ],
    );
  }
}
