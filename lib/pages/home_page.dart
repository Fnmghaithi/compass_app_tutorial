import 'package:compass_app_tutorial/widgets/compass_%20custompainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Compass App'),
      ),
      body: StreamBuilder(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error reading heading: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          double? direction = snapshot.data!.heading;

          // if direction is null,
          // then device does not support this sensor

          // show error message
          if (direction == null) {
            return const Center(
              child: Text("Device does not have sensors !"),
            );
          }

          return SizedBox(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: size,
                  painter: CompassCustomPainter(
                    angle: direction,
                  ),
                ),
                Text(
                  buildHeadingFirstLetter(direction),
                  style: TextStyle(
                    color: Colors.grey[700]!,
                    fontSize: 82,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String buildHeadingFirstLetter(double direction) {
  if (direction > 315 && direction < 45) {
    return 'N';
  } else if (direction > 45 && direction < 135) {
    return 'E';
  } else if (direction > 135 && direction < 225) {
    return 'S';
  } else if (direction > 225 && direction < 315) {
    return 'W';
  }

  return 'N';
}
