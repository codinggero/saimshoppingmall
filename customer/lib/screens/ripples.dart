import 'package:flutter/material.dart';

class Ripples extends StatefulWidget {
  const Ripples({
    super.key,
    this.size = 80.0,
    this.color = Colors.pink,
    this.onPressed,
    required this.child,
  });

  final double size;
  final Color color;
  final Widget child;
  final VoidCallback? onPressed;

  @override
  RipplesState createState() => RipplesState();
}

class RipplesState extends State<Ripples> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(widget.color);
  }

  Widget _buildBody(Color color) {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(100 * controller.value, color),
            _buildContainer(150 * controller.value, color),
            _buildContainer(200 * controller.value, color),
            _buildContainer(250 * controller.value, color),
            _buildContainer(300 * controller.value, color),
            const Align(
                child: Icon(
              color: Colors.white,
              Icons.mic_rounded,
              size: 44,
            )),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius, Color color) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(1 - controller.value),
      ),
    );
  }
}
