import 'package:locked_in/app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double percentage;

  const CustomLinearProgressIndicator({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 1.h,
          decoration: BoxDecoration(
            color: Colors.lightGreen.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        FractionallySizedBox(
          widthFactor: percentage/100,
          child: Container(
            height: 1.h,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}


class GradientSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  final LinearGradient gradient;

  GradientSliderTrackShape({required this.gradient});

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool isEnabled = false,
        bool isDiscrete = false,
      }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Calculate active portion of the track
    final Rect activeTrackRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeTrackRect);

    // Draw the active track with gradient
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeTrackRect, Radius.circular(4.0)),
      activePaint,
    );

    // Draw the inactive track (remaining part)
    final Rect inactiveTrackRect = Rect.fromLTRB(
      thumbCenter.dx,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );

    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.grey;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(inactiveTrackRect, Radius.circular(4.0)),
      inactivePaint,
    );
  }
}




class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final double borderThickness;
  final Color borderColor;
  final Color innerColor;

  CustomSliderThumbCircle({
    this.thumbRadius = 12.0,
    this.borderThickness = 4.0, // Thickness of the yellow border
    this.borderColor = Colors.yellow,
    this.innerColor = Colors.white, // Color of the inner circle
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    // Draw the outer yellow border
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness;

    canvas.drawCircle(center, thumbRadius, borderPaint);

    // Draw the inner white circle
    final Paint innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius - borderThickness / 2, innerPaint);
  }
}

