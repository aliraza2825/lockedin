import 'package:medical_courier/app/config/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    // Bounce Animation (Moves up & down)
    _bounceAnimation = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Scale Animation (Zoom in & out)
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child, // Main screen content

        if (widget.isLoading)
          Container(
            color: Colors.white.withOpacity(0.5), // Background overlay
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo with Bounce & Zoom effect
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _bounceAnimation.value),
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Image.asset(
                            'assets/pngs/logo.png',
                            width: 160,
                            height: 160,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),

                  // Static Loading Circle
                  CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
