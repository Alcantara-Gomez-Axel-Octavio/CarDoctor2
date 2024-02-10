import 'package:cardoctor/screen/mecanicopage.dart';
import 'package:flutter/material.dart';
import 'gruapage.dart';


class HerramientasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            _buildImageContainer(context, 'Grua', 'assets/imagenes/Grua.jpeg', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GruaPage()));
            }),
            SizedBox(height: 20),
            _buildImageContainer(context, 'Mecanico', 'assets/imagenes/Mecanico.jpeg', () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MecanicoPage()));

            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context, String title, String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(255, 195, 161, 255), blurRadius: 15, offset: Offset(5, 5)),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            const Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('Directorio de $title', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
