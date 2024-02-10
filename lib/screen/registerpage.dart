import 'package:cardoctor/screen/BaseDatos.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ColorarribaHome(size),
            ImagenCarro(),
            loginCuadro(context),
          ],
        ),
      ),
    );
  }

  Container ColorarribaHome(Size size) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1)
          ],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class ImagenCarro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: const Icon(Icons.person_add, color: Colors.white, size: 100),
          ),
        ],
      ),
    );
  }
}

SingleChildScrollView loginCuadro(BuildContext context) {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

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
                  color: Colors.black12, blurRadius: 15, offset: Offset(5, 5)),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text('Registrate', style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nombreController,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        hintText: 'Ejemplo@Ejemplo.com',
                        labelText: 'Crea un Correo',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                    ),
                    TextFormField(
                      controller: contrasenaController,
                      obscureText: true,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        hintText: '*****',
                        labelText: 'Crea una Clave',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      color: const Color.fromRGBO(90, 70, 178, 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        // Obtén los valores del formulario (nombre y contraseña)
                        String nombre = nombreController.text;
                        String contrasena = contrasenaController.text;

                        // Crea una instancia del helper de la base de datos
                        BaseDatos dbHelper = BaseDatos();
                        print('Contraseña durante el registro: $contrasena');
                        print(
                            'Credenciales ingresadas - Nombre: $nombre, Contraseña: $contrasena');

                        // Ejecuta la operación de apertura y de inserción de forma asíncrona
                        dbHelper.open().then((_) async {
                          // Inserta el usuario en la base de datos
                          await dbHelper.insertUsuario(nombre, contrasena);

                          // Ahora, verifica las credenciales después de insertar el usuario
                          dbHelper
                              .verificarCredenciales(nombre, contrasena)
                              .then((credencialesCorrectas) {
                            if (credencialesCorrectas) {
                              // Credenciales correctas, puedes hacer algo si es necesario
                              print(
                                  'Usuario registrado y credenciales verificadas');
                            } else {
                              print(
                                  'Credenciales incorrectas después del registro');
                              // Puedes mostrar un mensaje de error al usuario si lo deseas
                            }

                            // Finalmente, navega a la página 'login'
                            Navigator.pushReplacementNamed(context, 'login');
                          }).catchError((error) {
                            // Manejo de errores durante la verificación de credenciales
                            print('Error al verificar credenciales: $error');
                          });
                        }).catchError((error) {
                          // Manejo de errores
                          print('Error: $error');
                          // Puedes mostrar un mensaje de error al usuario si lo deseas
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        const Text('Ya tienes cuenta?',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
          child: const Text('Log In',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        )
      ],
    ),
  );
}