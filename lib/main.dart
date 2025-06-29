import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'core/viewmodel/cronometro_viewmodel.dart';
import 'core/accessibility/accessibility_config.dart';
import 'views/cronometro_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp(notificationsPlugin: flutterLocalNotificationsPlugin));
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  const MyApp({super.key, required this.notificationsPlugin});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CronometroViewModel(notificationsPlugin),
      child: MaterialApp(
        title: 'Cronômetro de Voltas',
        theme: AccessibilityConfig.getAccessibleTheme(),
        home: CronometroView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
