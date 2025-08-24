import 'package:calculator/blocObserve.dart';
import 'package:calculator/modules/History/cubit/cubit.dart';
import 'package:calculator/modules/History/history.dart';
import 'package:calculator/modules/home/cubit/cubit.dart';
import 'package:calculator/modules/home/home.dart';
import 'package:calculator/shared/network/local/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SqfliteHelper().initalDb();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(
    providers: [
       BlocProvider(create: (context)=> HomeCubit()),
       BlocProvider(create: (context)=> HistoryCubit())
    ],
    child: MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/':(context)=> Home(),
        '/history':(context)=> History()
      },
    ));
  }
}