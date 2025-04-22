import 'package:flutter/material.dart';
import 'package:weather_app/MainScreen.dart';
import 'dart:math' as math;

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(fit: StackFit.expand, children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://pics.craiyon.com/2023-11-16/wHGM0abcSOWVL1p6KEsCZw.webp'),
                  fit: BoxFit.cover),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Weather app ",
                  style: TextStyle(fontSize: 45, color: Colors.black),
                ),
                AnimatedBuilder(
                    animation: _controller,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: const Center(
                        child: Image(
                            image: NetworkImage(
                                'https://static.vecteezy.com/system/resources/thumbnails/010/989/531/small/hot-weather-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend-png.png')),
                      ),
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Transform.rotate(
                        angle: _controller.value * 2.0 * math.pi,
                        child: child,
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mainscreen()))
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          // backgroundColor: Colors.black,
                          color: Colors.black,
                          fontSize: 30),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
