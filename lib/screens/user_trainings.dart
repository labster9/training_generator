import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/trainings.dart';
import '../widgets/main_drawer.dart';
import '../widgets/training_item_tile.dart';

class UserTrainings extends StatefulWidget {
  static const routeName = '/user-trainings';

  @override
  _UserTrainingsState createState() => _UserTrainingsState();
}

class _UserTrainingsState extends State<UserTrainings> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Trainings>(context).fetchUserTrainings().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final trainings = Provider.of<Trainings>(context).trainings;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your trainings'),
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : trainings.isEmpty
              ? Center(child: Text('You have no trainings yet'))
              : Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: trainings.length,
                    itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                      value: trainings[index],
                      child: Column(
                        children: [TrainingItemTile(trainings[index], index)],
                      ),
                    ),
                  ),
                ),
    );
  }
}
