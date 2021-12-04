import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/screens/map_screen.dart';
import 'package:map_notes/business_logic/position_cubit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'ru_Ru';
    return MultiBlocProvider(
      providers: [
        BlocProvider<PositionCubit>(create: (BuildContext context) => PositionCubit()..getPosition()),
        BlocProvider<NoteCubit>(create: (BuildContext context) => NoteCubit()..loadNotes()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru', 'RU')],
        home: MapScreen(),
      ),
    );
  }
}
