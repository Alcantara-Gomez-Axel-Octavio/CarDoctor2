import 'package:cardoctor/screen/BaseDatos.dart';
import 'package:cardoctor/screen/loginpage.dart';
import 'package:flutter/material.dart';


class RegistrarVehiculoPage extends StatefulWidget {
  const RegistrarVehiculoPage({super.key});

  @override
  _RegistrarVehiculoPageState createState() => _RegistrarVehiculoPageState();
}

class _RegistrarVehiculoPageState extends State<RegistrarVehiculoPage> {
  late BaseDatos _baseDatos;
  late LoginPage _loginPage;
  bool isSedan = false;
  bool isPickup = false;
  bool isMoto = false;

  late String nombre;
  late int idUsuario;
  late int Kilometraje=0;
  late DateTime fecha;


    void initState() {
    super.initState();
    _loginPage = LoginPage();
    _baseDatos = BaseDatos() ; // Inicializa _loginPage aquí (o utiliza la forma apropiada de inicializarlo)
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ColorarribaHome(Size),
            ImagenCarro(),
            loginCuadro(context),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView loginCuadro(BuildContext context) {
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
                      offset: Offset(5, 5))
                ]),
            child: Column(children: [
              const SizedBox(height: 10),
              Text('Registre su vehiculo',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      onChanged: (value) {
                        // Asignar el valor a la variable
                        nombre = value;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        hintText: 'Ejemplo: Chevy sport',
                        labelText: 'Nombre a su automovil',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                    ),
                       Row(
                      children: [
                        Checkbox(
                          value: isSedan,
                          onChanged: (value) {
                            setState(() {
                              isSedan = value ?? false;
                              if (value ?? false) {
                                isPickup = false;
                                isMoto =
                                    false; // Añadido para desmarcar "Moto" cuando "Sedan" está seleccionado
                              }
                            });
                          },
                        ),
                        Text("Sedan"),
                        Checkbox(
                          value: isPickup,
                          onChanged: (value) {
                            setState(() {
                              isPickup = value ?? false;
                              if (value ?? false) {
                                isSedan = false;
                                isMoto =
                                    false; // Añadido para desmarcar "Moto" cuando "Pick Up" está seleccionado
                              }
                            });
                          },
                        ),
                        Text("Pick Up"),
                        Checkbox(
                          value:
                              isMoto, // Corregido a isMoto en lugar de isSedan
                          onChanged: (value) {
                            setState(() {
                              isMoto = value ?? false;
                              if (value ?? false) {
                                isSedan = false;
                                isPickup = false;
                              }
                            });
                          },
                        ),
                        Text("Moto"),
                      ],
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
                      onPressed: () async {
                        if(isSedan || isPickup || isMoto){
                         BaseDatos baseDatos = BaseDatos();

                          idUsuario = _loginPage.obtenerIdUsuario();

                          await baseDatos.open();
                          print('Id ususario: $idUsuario nombre: $nombre IdKilometraje: $Kilometraje ');

                          int idVehiculo = await _baseDatos.insertVehiculo(nombre, idUsuario);
        
                          await _baseDatos.insertKilometraje(Kilometraje,idUsuario,idVehiculo);

                          int Mantenimiento= await _baseDatos.insertMantenimiento(idVehiculo);


                              

                              if (isSedan) {

                                String fechaAfinacion = DateTime.now().add(Duration(days: 6 * 30)).toString();
                                idVehiculo = await _baseDatos.insertSedan(Mantenimiento, fechaAfinacion);

                              } else if (isPickup) {
                                
                                String fechaAfinacionPickUp = DateTime.now().add(Duration(days: 5 * 30)).toString();
                                idVehiculo = await _baseDatos.insertPickUp(Mantenimiento, fechaAfinacionPickUp);

                              } else if (isMoto) {

                                String fechaAfinacionMoto = DateTime.now().add(Duration(days: 4 * 30)).toString();
                                idVehiculo = await _baseDatos.insertMoto(Mantenimiento, fechaAfinacionMoto);

                              } else {
                                print('Ninguna opción seleccionada');
                              }

                  
                          await baseDatos.cerrarBaseDatos();
                          Navigator.pushReplacementNamed(context, 'home');

                        }else{
                          // Si ninguna opción está seleccionada, puedes manejarlo de acuerdo a tus necesidades
                          print('Ninguna opción seleccionada');
                        }
                      },
                    ),
                  ],
                ),
              )
            ]),
          ),
          const SizedBox(height: 50),
          const Text('No desea añadir ningun vehiculo?',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          TextButton(
            style: TextButton.styleFrom(
              // ignore: deprecated_member_use
              primary: Colors.black,
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
            child: const Text('Regresar',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

  

Container ColorarribaHome(Size Size) {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1)
    ])),
    width: double.infinity,
    height: double.infinity,
  );
}

SafeArea ImagenCarro() {
  return SafeArea(
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: const Icon(
            Icons.car_repair,
            color: Colors.white,
            size: 100,
          ),
        ),
      ],
    ),
  );
}