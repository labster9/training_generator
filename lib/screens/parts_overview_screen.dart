import 'package:flutter/material.dart';

import '../widgets/parts_grid.dart';

class PartsOverviewScreen extends StatelessWidget {
  static const routeName = '/parts-overview';
  @override
  Widget build(BuildContext context) {
    return PartsGrid();
  }
}
