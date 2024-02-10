import 'package:cardoctor/screen/BaseDatos.dart';
import 'package:cardoctor/screen/loginpage.dart';
import 'package:flutter/material.dart';

class KilometrajePage extends StatefulWidget {
  const KilometrajePage({super.key});

  @override
  _KilometrajePageState createState() => _KilometrajePageState();
}

class _KilometrajePageState extends State<KilometrajePage> {
  late BaseDatos _baseDatos;
  late LoginPage _loginPage;
  late TextEditingController nombreAutoController;
  late TextEditingController nuevoKilometrajeController;

  late String nombre;
  late int idUsuario;
  late int Kilometraje = 0;
  late DateTime fecha;

  void initState() {
    super.initState();
    _baseDatos = BaseDatos();
    _loginPage = LoginPage();
    nombreAutoController = TextEditingController();
    nuevoKilometrajeController = TextEditingController();
  }

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
          const SizedBox(height: 240),
          SizedBox(
            width: double.infinity,
            height: 600,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  child: Form(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    controller: nombreAutoController,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      labelText: 'Nombre del auto',
                                      labelStyle:
                                          TextStyle(color: Colors.deepPurple),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurple),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurple),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    controller: nuevoKilometrajeController,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      labelText: 'Actualiza tu km',
                                      labelStyle:
                                          TextStyle(color: Colors.deepPurple),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurple),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurple),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      // Obtener los valores de los controladores
                                      String nombreAuto =
                                          nombreAutoController.text;
                                      String nuevoKilometrajeStr =
                                          nuevoKilometrajeController.text;

                                      // Validar que la cadena sea un número antes de intentar la conversión
                                      int? nuevoKilometraje =
                                          int.tryParse(nuevoKilometrajeStr);

                                      if (nuevoKilometraje != null) {
                                        // Obtener el ID de usuario
                                        idUsuario =
                                            _loginPage.obtenerIdUsuario();

                                        // Insertar el nuevo kilometraje y obtener el resultado de manera asíncrona
                                        int kilometrajeRecorrido =
                                            await verificarKilometraje(
                                                nombreAuto,
                                                nuevoKilometraje,
                                                idUsuario);

                                        // Calcular meses restantes
                                        int distanciaEstimada = 15000;
                                        int mesesEstimados = 6;
                                        int mesesRestantes =
                                            ((distanciaEstimada -
                                                        kilometrajeRecorrido) /
                                                    distanciaEstimada *
                                                    mesesEstimados)
                                                .round();
                                        mesesRestantes = mesesRestantes.clamp(
                                            0, mesesEstimados);

                                        // Mostrar la fecha estimada en un diálogo
                                        mostrarDialogoFechaEstimada(
                                            mesesRestantes);
                                      } else {
                                        // La cadena no es un número válido
                                        print(
                                            'Por favor, ingresa un número válido.');
                                      }
                                    } catch (e) {
                                      print(
                                          'Error al procesar el nuevo kilometraje: $e');
                                      // Puedes agregar lógica adicional aquí si es necesario
                                    }
                                  },
                                  child: Text('Actualizar Kilometraje'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      // Obtener los valores de los controladores
                                      String nombreAuto =
                                          nombreAutoController.text;
                                      print(nuevoKilometrajeController.text);
                                      String nuevoKilometrajeStr =
                                          nuevoKilometrajeController.text;

                                      // Validar que la cadena sea un número antes de intentar la conversión
                                      int? nuevoKilometraje =
                                          int.tryParse(nuevoKilometrajeStr);

                                      if (nuevoKilometraje != null) {
                                        BaseDatos baseDatos = BaseDatos();
                                        await baseDatos.open();

                                        // Obtener el ID de usuario
                                        idUsuario =
                                            _loginPage.obtenerIdUsuario();

                                        // Insertar el nuevo kilometraje y obtener el resultado de manera asíncrona
                                        int kilometrajeRecorrido =
                                            await insertarNuevoKilometraje(
                                                nombreAuto,
                                                nuevoKilometraje,
                                                idUsuario);
                                        await baseDatos.cerrarBaseDatos();

                                        // Ahora puedes utilizar la variable 'kilometrajeRecorrido' como necesites
                                        print(
                                            'Kilómetros recorridos: $kilometrajeRecorrido');
                                      } else {
                                        // La cadena no es un número válido
                                        print(
                                            'Por favor, ingresa un número válido.');
                                      }
                                    } catch (e) {
                                      print(
                                          'Error al procesar el nuevo kilometraje: $e');
                                      // Puedes agregar lógica adicional aquí si es necesario
                                    }
                                  },
                                  child: Text('Ya realice la afinacion'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

  void mostrarDialogoFechaEstimada(int mesesRestantes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Próxima Afinación'),
          content:
              Text('Se recomienda una afinación en $mesesRestantes meses.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<int> verificarKilometraje(
      String nombreAuto, int nuevoKilometraje, int idUsuario) async {
    final result =
        await _baseDatos.obtenerVehiculoYKilometraje(nombreAuto, idUsuario);

    if (result != null) {
      result['idVehiculo'] as int;
      int kilometrajeAnterior = result['kilometrajeAnterior'] as int;

      // Calcular los kilómetros recorridos
      int kilometrosRecorridos = nuevoKilometraje - kilometrajeAnterior;

      // Operación completada, cerrar la base de datos
      _baseDatos.cerrarBaseDatos();

      // Utilizar la variable 'kilometrosRecorridos' según tus necesidades
      print('Kilómetros recorridos: $kilometrosRecorridos');
      return kilometrosRecorridos;
    } else {
      print('Vehículo no encontrado');
      return 0;
    }
  }

  Future<int> insertarNuevoKilometraje(
      String nombreAuto, int nuevoKilometraje, int idUsuario) async {
    final result =
        await _baseDatos.obtenerVehiculoYKilometraje(nombreAuto, idUsuario);

    if (result != null) {
      int idVehiculo = result['idVehiculo'] as int;
      int kilometrajeAnterior = result['kilometrajeAnterior'] as int;

      // Calcular los kilómetros recorridos
      int kilometrosRecorridos = nuevoKilometraje - kilometrajeAnterior;

      // Insertar el nuevo kilometraje
      await _baseDatos.insertKilometraje(
          nuevoKilometraje, idUsuario, idVehiculo);

      // Operación completada, cerrar la base de datos
      _baseDatos.cerrarBaseDatos();

      // Utilizar la variable 'kilometrosRecorridos' según tus necesidades
      print('Kilómetros recorridos: $kilometrosRecorridos');
      return kilometrosRecorridos;
    } else {
      print('Vehículo no encontrado');
      return 0;
    }
  }
}
