import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercise_provider.dart';
import '../widgets/exercise_item.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ExerciseProvider>(context, listen: false)
          .fetchExercises()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshFavs(BuildContext context) async {
    await Provider.of<ExerciseProvider>(context, listen: false)
        .fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteExercises =
        Provider.of<ExerciseProvider>(context).favExercises;
    return RefreshIndicator(
      onRefresh: () => _refreshFavs(context),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteExercises.isEmpty
              ? Center(child: Text('You have no favorites yet'))
              : ListView.builder(
                  itemCount: favoriteExercises.length,
                  itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    // create: (c) => partExercises[index],
                    value: favoriteExercises[index],
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
