import 'package:flutter/material.dart';

class GruaPage extends StatefulWidget {
  const GruaPage({Key? key}) : super(key: key);

  @override
  _GruaPageState createState() => _GruaPageState();
}

class _GruaPageState extends State<GruaPage> {
  List<LocationInfo> locations = [
    
    LocationInfo('Zapopan', 'Grua Zapopan', [
      GruainformacionDelServicio('Gruas24x7', '332238512'),
    ]),
    LocationInfo('Tlaquepaque', 'Grua Tlaquepaque', [
      GruainformacionDelServicio('GrúasExpress', '3322385127'),
    ]),
    LocationInfo('Guadalajara', 'Grua Guadalajara', [
      GruainformacionDelServicio('MyGrua', '3338200171'),
    ]),
    LocationInfo('Tonala', 'Grua Tonala', [
      GruainformacionDelServicio('Umbursa', '3312040626'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildImageContainer(context),
            const SizedBox(height: 20),
            _buildDirectory(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(color: Color.fromARGB(255, 195, 161, 255), blurRadius: 15, offset: Offset(5, 5))],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text('Te intentaremos brindarte apoyo', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Action when clicking on the image
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/imagenes/Grua.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          const Text(
            'Este directorio está distribuido por zonas cercanas a la zona metropolitana de Guadalajara por si llegas a necesitar.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectory() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(color: Color.fromARGB(255, 195, 161, 255), blurRadius: 15, offset: Offset(5, 5))],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Directorio de Grúas', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            children: locations.map((location) {
              return _buildGruaListTile(context, location);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGruaListTile(BuildContext context, LocationInfo location) {
    return ListTile(
      title: Text(location.locationName),
      onTap: () {
        _showGruaDialog(context, location);
      },
    );
  }

  void _showGruaDialog(BuildContext context, LocationInfo location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(location.nombreGrua),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var informacionDelServicio in location.services)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${informacionDelServicio.nombreServicio}:'),
                    const SizedBox(height: 10),
                    Text('Número de teléfono: ${informacionDelServicio.numeroTelefonico}'),
                    const SizedBox(height: 20),
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class LocationInfo {
  final String locationName;
  final String nombreGrua;
  final List<GruainformacionDelServicio> services;

  LocationInfo(this.locationName, this.nombreGrua, this.services);
}

class GruainformacionDelServicio {
  final String nombreServicio;
  final String numeroTelefonico;

  GruainformacionDelServicio(this.nombreServicio, this.numeroTelefonico);
}
