import 'package:flutter/material.dart';

Future<dynamic> deleteNoteDialog({required BuildContext context, required VoidCallback onConfirm}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: const [
            Text('Удалить заметку?'),
          ],
        ),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: const Text('Подтвердить'),
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
