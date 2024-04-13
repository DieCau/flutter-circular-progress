import 'package:flutter/material.dart';
import 'package:circular_progress/src/widgets/radial_progress.dart';

class GraficasCiruclares extends StatefulWidget {
  const GraficasCiruclares({super.key});

  @override
  State<GraficasCiruclares> createState() => _GraficasCiruclaresState();
}

class _GraficasCiruclaresState extends State<GraficasCiruclares> {
  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const StadiumBorder(),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              porcentaje += 10;
              if (porcentaje > 100) {
                porcentaje = 0;
              }
            });
          },
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            CustomRadialProgress(porcentaje: porcentaje, color: Colors.blue),
            CustomRadialProgress(porcentaje: porcentaje, color: Colors.black),
            CustomRadialProgress(porcentaje: porcentaje, color: Colors.red)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomRadialProgress(porcentaje: porcentaje, color: Colors.amber),
            CustomRadialProgress(porcentaje: porcentaje, color: Colors.green)
          ])
        ]));
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color color;
  const CustomRadialProgress({
    super.key,
    required this.porcentaje, 
    required this.color,
  });

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 130,
      width: 130,
      child: RadialProgress(
        porcentaje: porcentaje,
        colorPrimary: color,
        colorSecondary: Colors.grey,
        widePrimary: 8,
        wideSecondary: 2,
      ),
      // Text('$porcentaje %',style: const TextStyle(fontSize: 50.0),
    );
  }
}
