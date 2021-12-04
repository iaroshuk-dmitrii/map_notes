import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Справка'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Создание заметки:', style: TextStyle(fontSize: 16)),
              ),
              Text('Длительно нажмите на любом месте карты.'),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Просмотр заметки:', style: TextStyle(fontSize: 16)),
              ),
              Text('Нажмите на иконку заметки на экране карты.'),
              Text('Нажмите на заметку на экране заметок.'),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Удаление заметки:', style: TextStyle(fontSize: 16)),
              ),
              Text('Перейдите на экран заметки, нажмите удалить и подтвердите удаление.'),
              Text('Длительно нажмите на заметку,на экране заметок и подтвердите удаление.'),
            ],
          ),
        ),
      ),
    );
  }
}
