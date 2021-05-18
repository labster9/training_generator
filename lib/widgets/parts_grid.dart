import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/part_provider.dart';
import './part_item.dart';

class PartsGrid extends StatefulWidget {
  @override
  _PartsGridState createState() => _PartsGridState();
}

class _PartsGridState extends State<PartsGrid> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<PartProvider>(context).fetchParts().then((_) {
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
    final partsData = Provider.of<PartProvider>(context);
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: partsData.parts.length,
            itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: partsData.parts[index],
              child: PartItem(),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
