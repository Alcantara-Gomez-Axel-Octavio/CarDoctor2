import 'package:cardoctor/screen/homepage.dart';
import 'package:cardoctor/screen/kilometrajepage.dart';
import 'package:cardoctor/screen/loginpage.dart';
import 'package:cardoctor/screen/registerpage.dart';
import 'package:cardoctor/screen/registrarvehiculopage.dart';
import 'package:cardoctor/screen/serviciospage.dart';
import 'package:cardoctor/screen/herramientaspage.dart';
import 'package:cardoctor/screen/gruapage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {
        'login': (_) => LoginPage(),
        'home': (_) => const HomePage(),
        'register': (_) => const RegisterPage(),
        'registerVehiculo': (_) => const RegistrarVehiculoPage(),
        'Kilometraje': (_) => const KilometrajePage(),
        'servicios': (_) => const ServiciosPage(),
        'herramientas': (_) => HerramientasPage(),
        'grua': (_) => const GruaPage(),
      },
      initialRoute: 'login',
    );
  }
}
