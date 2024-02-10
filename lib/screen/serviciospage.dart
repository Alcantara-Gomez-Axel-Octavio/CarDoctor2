import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ServiciosPage extends StatefulWidget {
  const ServiciosPage({Key? key}) : super(key: key);

  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  late VideoPlayerController videoPlayerController1;
  late VideoPlayerController videoPlayerController2;
  late VideoPlayerController videoPlayerController3;
  late double videoSliderValue1 = 0.0;
  late double videoSliderValue2 = 0.0;
  late double videoSliderValue3 = 0.0;

  @override
  void initState() {
    super.initState();

    // Primer video sobre cambiar el anticongelante o agua
    videoPlayerController1 = VideoPlayerController.asset(
      'assets/videos/Anticongelante.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Segundo video sobre cambiar el aceite
    videoPlayerController2 = VideoPlayerController.asset(
      'assets/videos/CambiarLLanta.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Tercer video sobre cambiar el aceite
    videoPlayerController3 = VideoPlayerController.asset(
      'assets/videos/LimpiaParabrisas.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Agrega listener para actualizar el valor del slider para el primer video
    videoPlayerController1.addListener(() {
      if (mounted) {
        setState(() {
          videoSliderValue1 =
              videoPlayerController1.value.position.inSeconds.toDouble();
        });
      }
    });

    // Agrega listener para actualizar el valor del slider para el segundo video
    videoPlayerController2.addListener(() {
      if (mounted) {
        setState(() {
          videoSliderValue2 =
              videoPlayerController2.value.position.inSeconds.toDouble();
        });
      }
    });

    videoPlayerController3.addListener(() {
      if (mounted) {
        setState(() {
          videoSliderValue3 =
              videoPlayerController2.value.position.inSeconds.toDouble();
        });
      }
    });
  }

  @override
  void dispose() {
    videoPlayerController1.dispose();
    videoPlayerController2.dispose();
    videoPlayerController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            _buildVideoContainer(context, 'Cambiar el anticongelante o Agua',
                videoPlayerController1, videoSliderValue1),
            const SizedBox(height: 40),
            _buildVideoContainer(context, 'Cambiar una llanata',
                videoPlayerController2, videoSliderValue2),
            const SizedBox(height: 40),
            _buildVideoContainer(context, 'Liquido de Limpia Parabrisas',
                videoPlayerController3, videoSliderValue3),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoContainer(BuildContext context, String videoTitle,
      VideoPlayerController controller, double sliderValue) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 195, 161, 255),
            blurRadius: 15,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(videoTitle,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.black,
                  )),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(controller),
            ),
          ),
          SizedBox(height: 20),
          Slider(
            value: sliderValue,
            min: 0.0,
            max: controller.value.duration.inSeconds.toDouble(),
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
              controller.seekTo(Duration(seconds: value.toInt()));
            },
          ),
        ],
      ),
    );
  }
}
