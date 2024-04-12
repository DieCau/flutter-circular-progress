import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';


class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({super.key});

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double porcentaje = 10.0;
  double nuevoPorcentaje = 0.0;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    controller.addListener(() {
      // print('valor controller: ${controller.value}');
      
      setState(() {
        porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, controller.value)!;
      });

    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Container(
          padding: const EdgeInsets.all(3),
          width: 300,
          height: 300,
          // color: Colors.deepPurple,
          child: CustomPaint(
            painter: _MiRadialProgress(porcentaje),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          porcentaje += 10;
          if (porcentaje > 100) {
            porcentaje = 0;
          }

          controller.forward(from: 0.0);
          setState(() {});
        },
        shape: const StadiumBorder(),
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final double porcentaje;

  _MiRadialProgress(this.porcentaje);

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completo
    // Crear el lapiz
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    // Variables para dibujar el drawCircle
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radio = min(size.width * 0.5, size.height * 0.5);

    // Dibujar el circulo y ubicacion del centro
    canvas.drawCircle(center, radio, paint);

    // Dibujar el Arco
    final paintArco = Paint()
      ..strokeWidth = 10
      ..color = Colors.green
      ..style = PaintingStyle.stroke;

    // Parte que se irá llenando
    double arcAngle = 2 * pi * (porcentaje / 100);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radio), -pi / 2, arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
