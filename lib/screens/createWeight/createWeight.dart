import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/models/userModel.dart';
import 'package:weight_tracker/screens/createWeight/widgets/formField.dart';
import 'package:weight_tracker/services/database.dart';
import 'package:weight_tracker/utils/loader.dart';
import 'package:weight_tracker/utils/sizeConfig.dart';
import 'package:weight_tracker/utils/strings.dart';

class CreateWeight extends StatefulWidget {
  @override
  _CreateWeightState createState() => _CreateWeightState();
}

class _CreateWeightState extends State<CreateWeight> {
  final _newWeightKey = GlobalKey<FormState>();

  final TextEditingController _weightFormFieldController =
      TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    SizeConfig().init(context);
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.grey[600],
              elevation: 0.0,
              title: Text(newWeightScreenTitle),
            ),
            body: Form(
              key: _newWeightKey,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 5),
                    ),
                  ),
                  height: SizeConfig.blockSizeVertical * 40,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 9,
                      ),
                      NewSessionFormField(
                        fieldController: _weightFormFieldController,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_newWeightKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            DateTime now = DateTime.now();
                            final formatter =
                                new DateFormat('yyyy-MM-dd hh:mm:ss');
                            String convertedDateTime = formatter.format(now);
                            DatabaseService().addNewWeight(
                                user.uid,
                                _weightFormFieldController.text,
                                convertedDateTime);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(submit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
