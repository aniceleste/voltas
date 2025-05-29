import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/cronometro_view.dart';
import 'core/viewmodel/cronometro_viewmodel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CronometroViewModel(flutterLocalNotificationsPlugin),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro de Voltas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CronometroView(),
    );
  }
}