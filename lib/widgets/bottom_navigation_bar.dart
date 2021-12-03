import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key, required this.navigationType, this.onPressedMap, this.onPressedNotes})
      : super(key: key);

  final NavigationType navigationType;
  final VoidCallback? onPressedMap;
  final VoidCallback? onPressedNotes;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BottomMapIcon(
          color: navigationType == NavigationType.map ? Colors.blue : Colors.grey,
          onPressed: onPressedMap,
        ),
        BottomNotesIcon(
          color: navigationType == NavigationType.notes ? Colors.blue : Colors.grey,
          onPressed: onPressedNotes,
        )
      ],
    );
  }
}

class BottomMapIcon extends StatelessWidget {
  const BottomMapIcon({Key? key, required this.color, this.onPressed}) : super(key: key);

  final Color color;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(
              Icons.map,
              color: color,
            ),
            Text(
              'Карта',
              style: TextStyle(color: color),
            )
          ],
        ));
  }
}

class BottomNotesIcon extends StatelessWidget {
  const BottomNotesIcon({Key? key, required this.color, this.onPressed}) : super(key: key);

  final Color color;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(
              Icons.notes,
              color: color,
            ),
            Text(
              'Заметки',
              style: TextStyle(color: color),
            )
          ],
        ));
  }
}

enum NavigationType { map, notes }
