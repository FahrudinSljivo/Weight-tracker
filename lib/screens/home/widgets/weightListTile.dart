import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/models/userModel.dart';
import 'package:weight_tracker/models/weightModel.dart';
import 'package:weight_tracker/screens/home/widgets/editWeightDialog.dart';
import 'package:weight_tracker/services/database.dart';
import 'package:weight_tracker/utils/sizeConfig.dart';
import 'package:weight_tracker/utils/strings.dart';

class WeightListTile extends StatefulWidget {
  final WeightModel weightModel;

  WeightListTile({this.weightModel});

  @override
  _WeightListTileState createState() => _WeightListTileState();
}

class _WeightListTileState extends State<WeightListTile> {
  final _editWeightKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    SizeConfig().init(context);
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 5,
        ),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: SizeConfig.safeBlockHorizontal * 7,
        ),
      ),
      key: Key(widget.weightModel.weightId),
      child: ListTile(
        title: Text(weight + ": " + widget.weightModel.weight + "kg"),
        subtitle: Text(date + ": " + widget.weightModel.time.substring(0, 10)),
        tileColor: Colors.grey[100],
        trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              displayEditWeightDialog(
                  context,
                  user.uid,
                  widget.weightModel.weightId,
                  _textFieldController,
                  _editWeightKey);
            }),
      ),
      onDismissed: (direction) async {
        await DatabaseService()
            .deleteWeight(widget.weightModel.weightId, user.uid);
      },
    );
  }
}
