import 'package:flutter/material.dart';
import 'package:cardoctor/screen/kilometrajepage.dart';
import 'herramientaspage.dart';
import 'serviciospage.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ImageContainer extends StatelessWidget {
  final String title, imagePath;
  final Widget page;

  const ImageContainer({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => page)),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 195, 161, 255),
              blurRadius: 10,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100, // Establecer la altura deseada
            ),
            const SizedBox(height: 5),
            Text('$title', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ColorFondo(Size),
            Botones(context),
            Positioned(
              top: 25,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    // Navegar a la otra ventana al presionar el botón
                    Navigator.pushReplacementNamed(context, 'registerVehiculo');
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container ColorFondo(Size Size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  SingleChildScrollView Botones(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 120),
          SizedBox(
            width: double.infinity,
            height: 600,
            child: Column(
              children: [
                const SizedBox(height: 2),
                Container(
                  child: Form(
                    child: Column(
                      children: [
                        const SizedBox(height: 2),
                        const ImageContainer(
                          title: 'Kilometraje',
                          imagePath: 'assets/imagenes/Kilometraje.png',
                          page: KilometrajePage(),
                        ),
                        const SizedBox(height: 4),
                        const ImageContainer(
                          title: 'Servicio',
                          imagePath: 'assets/imagenes/Servicios.png',
                          page: ServiciosPage(),
                        ),
                        const SizedBox(height: 4),
                        ImageContainer(
                          title: 'Herramientas',
                          imagePath: 'assets/imagenes/Herramientas.png',
                          page: HerramientasPage(),
                        ),
                        const SizedBox(height: 4),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          disabledColor: Colors.grey,
                          color: Colors.red,
                          onPressed: () {
                            FlutterPhoneDirectCaller.callNumber('911');
                          },
                          child: const SizedBox(
                            width: 365,
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons
                                      .emergency, // Reemplaza con el icono que desees
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                    width:
                                        10), // Espacio entre el icono y el texto
                                Text(
                                  '¡Emergencia! 911',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
