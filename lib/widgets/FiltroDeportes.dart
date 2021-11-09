import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FiltroDeportes extends StatelessWidget {
  const FiltroDeportes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        margin: EdgeInsets.only(bottom: 30, left :20, right:20),
        shape: StadiumBorder(),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.group_work, size: 30, color: Colors.orange),
              Icon(Icons.sports_soccer, size: 30),
              Icon(Icons.sports_basketball, size: 30),
              Icon(Icons.fitness_center , size: 30),
              Icon(Icons.sports_tennis, size: 30),
              Icon(Icons.skateboarding, size: 30)
            ]
        ),
      ),
    );
  }
}