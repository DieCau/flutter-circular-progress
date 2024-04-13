import 'dart:math';
import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double porcentaje;
  final Color colorPrimary;
  final Color colorSecondary;
  final double widePrimary;
  final double wideSecondary;

  const RadialProgress(
      {super.key,
      required this.porcentaje,
      this.colorPrimary = Colors.blue,
      this.colorSecondary = Colors.grey,
      this.widePrimary = 10,
      this.wideSecondary = 4});

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
                (widget.porcentaje - diferenciaAnimar) + (diferenciaAnimar * controller.value),
                widget.colorPrimary,
                widget.colorSecondary,
                widget.widePrimary,
                widget.wideSecondary),
          ),
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final double porcentaje;
  final Color colorPrimary;
  final Color colorSecondary;
  final double widePrimary;
  final double wideSecondary;

  _MiRadialProgress(this.porcentaje, this.colorPrimary, this.colorSecondary, this.wideSecondary,
      this.widePrimary);

  @override
  void paint(Canvas canvas, Size size) {
    
    // Para aplicar Gradiente
    // final Rect rect = Rect.fromCircle(
    //   center: const Offset(100, 0), 
    //   radius: 100
    // );

    // const Gradient gradient = LinearGradient(colors: <Color>[
    //   Color.fromARGB(255, 42, 255, 18),
    //   Color.fromARGB(255, 31, 147, 220),
    //   Color.fromARGB(255, 37, 10, 211),
    // ]);

    // Circulo completado
    // Crear el lapiz
    final paint = Paint()
      ..strokeWidth = widePrimary
      ..color = colorSecondary
      ..style = PaintingStyle.stroke;

    // Variables para dibujar el drawCircle
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radio = min(size.width * 0.5, size.height * 0.5);

    // Dibujar el circulo y ubicacion del centro
    canvas.drawCircle(center, radio, paint);

    // Dibujar el Arco
    final paintArco = Paint()
      ..strokeWidth = wideSecondary
      .. color      = colorPrimary
      // ..shader = gradient.createShader(rect) // Para utilizar gradiente
      ..strokeCap   = StrokeCap.round
      ..style       = PaintingStyle.stroke;

    // Parte que se irá llenando
    double arcAngle = 2 * pi * (porcentaje / 100);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radio), -pi / 2, arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
