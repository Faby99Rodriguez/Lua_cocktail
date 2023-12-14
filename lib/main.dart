import 'package:cocktail/Pages/check_auth_screen.dart';
import 'package:cocktail/Pages/login_screen.dart';
import 'package:cocktail/Pages/register_screen.dart';
import 'package:cocktail/services/cock_provider.dart';
import 'package:cocktail/providers/login_form_provider.dart';
import 'package:cocktail/screens/home_screen.dart';
import 'package:cocktail/services/auth_services.dart';
import 'package:cocktail/services/notifications_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => Btd6Provider(),
        //   lazy: false,
        // ),
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: 'login', // Puedes establecer la ruta inicial si lo deseas
      routes: {
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen(),
        'home': (context) => HomeScreen(apiService: apiService),
         'checking': (_) => CheckAuthScreen()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
          theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color.fromARGB(255, 163, 146, 152),
          //appBarTheme: const AppBarTheme(elevation: 0, color: Color.fromARGB(255, 63, 161, 76)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 212, 60, 14), elevation: 0)),
    );
  }
}



