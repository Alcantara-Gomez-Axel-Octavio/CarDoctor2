import 'package:flutter/material.dart';
import 'BaseDatos.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

  int obtenerIdUsuario() {
    return _LoginPageState.idUsuario;
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  static int idUsuario = 0;

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ColorArriba(Size),
            Imagen(),
            LoginCuadro(context),
          ],
        ),
      ),
    );
  }

  SafeArea Imagen() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 70),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container ColorArriba(Size Size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1),
        ]),
      ),
      width: double.infinity,
      height: Size.height * 0.4,
    );
  }

  Widget LoginCuadro(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 300),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 30),
                Container(
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nombreController,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurple,
                                width: 2,
                              ),
                            ),
                            hintText: 'Ejemplo@Ejemplo.com',
                            labelText: 'Correo',
                            prefixIcon: Icon(Icons.alternate_email),
                          ),
                        ),
                        TextFormField(
                          controller: contrasenaController,
                          autocorrect: false,
                          obscureText: true,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurple,
                                width: 2,
                              ),
                            ),
                            hintText: '*****',
                            labelText: 'Clave',
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledColor: Colors.grey,
                          color: const Color.fromRGBO(90, 70, 178, 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 15,
                            ),
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () async {
                            String nombre = nombreController.text;
                            String contrasena = contrasenaController.text;

                            print(
                                'Credenciales ingresadas - Nombre: $nombre, Contraseña: $contrasena');

                            BaseDatos dbHelper = BaseDatos();

                            dbHelper.open().then((_) {
                              dbHelper
                                  .verificarCredenciales(nombre, contrasena)
                                  .then((credencialesCorrectas) async {
                                if (credencialesCorrectas) {
                                  print(
                                      'Credenciales correctas al iniciar sesión');

                                  int? idUsuarioNullable =
                                      await dbHelper.obtenerIdUsuario(nombre);

                                  if (idUsuarioNullable != null) {
                                    setState(() {
                                      idUsuario = idUsuarioNullable;
                                      print(
                                          'Id del usaurio que entro: $idUsuario');
                                    });

                                    Navigator.pushReplacementNamed(
                                        context, 'home');
                                  } else {
                                    print(
                                        'No se pudo obtener el ID del usuario');
                                  }
                                } else {
                                  print(
                                      'Credenciales incorrectas al iniciar sesión');
                                  // Puedes mostrar un mensaje de error al usuario si lo deseas
                                }
                              }).catchError((error) {
                                print(
                                    'Error al verificar credenciales: $error');
                              });
                            }).catchError((error) {
                              print('Error al abrir la base de datos: $error');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'register');
                  },
                  child: const Text('Crear cuenta',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(90, 70, 178, 1))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
