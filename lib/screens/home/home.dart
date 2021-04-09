import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/models/userModel.dart';
import 'package:weight_tracker/models/weightModel.dart';
import 'package:weight_tracker/screens/createWeight/createWeight.dart';
import 'package:weight_tracker/screens/home/widgets/weightListTile.dart';
import 'package:weight_tracker/services/auth.dart';
import 'package:weight_tracker/utils/loader.dart';
import 'package:weight_tracker/utils/sizeConfig.dart';
import 'package:weight_tracker/utils/strings.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(homeScreenTitle),
        backgroundColor: Colors.grey[600],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app_rounded),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateWeight(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .collection("weights")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loader();
            } else {
              List<WeightModel> weightItems = snapshot.data.docs
                  .map((item) => WeightModel(
                      weight: item["weight"],
                      time: item["timestamp"],
                      weightId: item.id))
                  .toList()
                  .cast<WeightModel>();
              if (weightItems.length == 0) {
                return Center(
                  child: Text(noWeightsAddedMessage),
                );
              } else {
                return new ListView.separated(
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                  itemCount: weightItems.length,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    WeightModel item =
                        weightItems[weightItems.length - index - 1];
                    return new WeightListTile(
                      weightModel: item,
                    );
                  },
                );
              }
            }
          }),
    );
  }
}
