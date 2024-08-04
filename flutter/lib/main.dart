import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/feature/home/cubit/home_page_cubit.dart';
import 'package:todo_app_flutter/feature/home/home_page.dart';
import 'package:todo_app_flutter/infrastructure/di/di_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiHandler.configureDi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (context) => HomePageCubit(), child: const HomePage()),
    );
  }
}
