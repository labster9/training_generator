import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trainings.dart';
import '../providers/exercise_provider.dart';
import '../providers/exercise.dart';
import '../widgets/main_drawer.dart';

class GeneratorScreen extends StatefulWidget {
  static const routeName = '/generator';

  // final Function saveFilters;
  // final Map<String, bool> currentFilters;

  // FiltersScreen(this. currentFilters, this.saveFilters);

  @override
  _GeneratorScreenState createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  var _isInit = true;

  @override
  didChangeDependencies() {
    if (_isInit) {
      Provider.of<ExerciseProvider>(context).fetchExercises();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  bool _chest = false;
  bool _back = false;
  bool _shoulders = false;
  bool _biceps = false;
  bool _triceps = false;
  bool _legs = false;
  bool _forearms = false;
  bool _abs = false;

  Widget _buildSwitchListTile(
    String title,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generator'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Choose parts to train.\nWe recommend training maximum 3 parts per session.',
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Chest',
                  _chest,
                  (newValue) {
                    setState(
                      () {
                        _chest = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Back',
                  _back,
                  (newValue) {
                    setState(
                      () {
                        _back = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Shoulders',
                  _shoulders,
                  (newValue) {
                    setState(
                      () {
                        _shoulders = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Biceps',
                  _biceps,
                  (newValue) {
                    setState(
                      () {
                        _biceps = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Triceps',
                  _triceps,
                  (newValue) {
                    setState(
                      () {
                        _triceps = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Legs',
                  _legs,
                  (newValue) {
                    setState(
                      () {
                        _legs = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Forearms',
                  _forearms,
                  (newValue) {
                    setState(
                      () {
                        _forearms = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'ABS',
                  _abs,
                  (newValue) {
                    setState(
                      () {
                        _abs = newValue;
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Generate!'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepOrange)),
                  onPressed: () {
                    final selectedFilters = {
                      'chest': _chest,
                      'back': _back,
                      'shoulders': _shoulders,
                      'biceps': _biceps,
                      'triceps': _triceps,
                      'legs': _legs,
                      'forearms': _forearms,
                      'abs': _abs,
                    };
                    final availableExercises =
                        Provider.of<ExerciseProvider>(context, listen: false)
                            .filterExercisesv2(selectedFilters);
                    final ti = TrainingItem(
                        exercises: availableExercises, date: DateTime.now());
                    Provider.of<Trainings>(context, listen: false)
                        .addTraining(ti);
                    // Consumer<Trainings>(builder: (context, t, _) {
                    //   t.addTraining(ti);
                    // });
                    Navigator.of(context).pushReplacementNamed(
                        '/generated-training',
                        arguments: ti);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
