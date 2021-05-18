import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercise_provider.dart';
import '../widgets/exercise_item.dart';

class PartExercises extends StatefulWidget {
  static const routeName = '/part-exercises';

  @override
  _PartExercisesState createState() => _PartExercisesState();
}

class _PartExercisesState extends State<PartExercises> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ExerciseProvider>(context).fetchExercises().then((_) {
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
    final partName = ModalRoute.of(context).settings.arguments;
    final partExercises =
        Provider.of<ExerciseProvider>(context).partSelector(partName);
    return Scaffold(
      appBar: AppBar(
        title: Text(partName),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: partExercises.length,
              itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                // create: (c) => partExercises[index],
                value: partExercises[index],
                child: Column(
                  children: [
                    ExerciseItem(
                        // partExercises[index].id,
                        // partExercises[index].title,
                        // partExercises[index].imageUrl,
                        ),
                    Divider(color: Colors.black),
                  ],
                ),
              ),
            ),
    );
  }
}
