import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/trainings.dart';

class TrainingItemTile extends StatefulWidget {
  final TrainingItem training;
  final int index;

  TrainingItemTile(this.training, this.index);

  @override
  _TrainingItemTileState createState() => _TrainingItemTileState();
}

class _TrainingItemTileState extends State<TrainingItemTile> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('Training ${widget.index + 1}'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy').format(widget.training.date)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<Trainings>(context, listen: false)
                        .removeTraining(widget.training);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.double_arrow),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/generated-training',
                        arguments: widget.training);
                  },
                ),
                IconButton(
                    icon:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    }),
              ],
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              height: min(widget.training.exercises.length * 20.0 + 20, 300),
              child: ListView(
                children: widget.training.exercises
                    .map(
                      (ti) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(ti.title)],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
