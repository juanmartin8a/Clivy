import 'package:flutter/material.dart';

class TrimEditorPainter extends CustomPainter {
  /// To define the start offset
  final Offset startPos;

  /// To define the end offset
  final Offset endPos;

  /// To define the horizontal length of the selected video area
  final double scrubberAnimationDx;

  /// For specifying a size to the holder at the
  /// two ends of the video trimmer area, while it is `idle`.
  /// By default it is set to `0.5`.
  final double circleSize;

  /// For specifying the width of the border around
  /// the trim area. By default it is set to `3`.
  final double borderWidth;

  /// For specifying the width of the video scrubber
  final double scrubberWidth;

  /// For specifying whether to show the scrubber
  final bool showScrubber;

  /// For specifying a color to the border of
  /// the trim area. By default it is set to `Colors.white`.
  final Color borderPaintColor;

  /// For specifying a color to the circle.
  /// By default it is set to `Colors.white`
  final Color circlePaintColor;

  /// For specifying a color to the video
  /// scrubber inside the trim area. By default it is set to
  /// `Colors.white`.
  final Color scrubberPaintColor;

  /// For drawing the trim editor slider
  ///
  /// The required parameters are [startPos], [endPos]
  /// & [scrubberAnimationDx]
  ///
  /// * [startPos] to define the start offset
  ///
  ///
  /// * [endPos] to define the end offset
  ///
  ///
  /// * [scrubberAnimationDx] to define the horizontal length of the
  /// selected video area
  ///
  ///
  /// The optional parameters are:
  ///
  /// * [circleSize] for specifying a size to the holder at the
  /// two ends of the video trimmer area, while it is `idle`.
  /// By default it is set to `0.5`.
  ///
  ///
  /// * [borderWidth] for specifying the width of the border around
  /// the trim area. By default it is set to `3`.
  ///
  ///
  /// * [scrubberWidth] for specifying the width of the video scrubber
  ///
  ///
  /// * [showScrubber] for specifying whether to show the scrubber
  ///
  ///
  /// * [borderPaintColor] for specifying a color to the border of
  /// the trim area. By default it is set to `Colors.white`.
  ///
  ///
  /// * [circlePaintColor] for specifying a color to the circle.
  /// By default it is set to `Colors.white`.
  ///
  ///
  /// * [scrubberPaintColor] for specifying a color to the video
  /// scrubber inside the trim area. By default it is set to
  /// `Colors.white`.
  ///
  TrimEditorPainter({
    required this.startPos,
    required this.endPos,
    required this.scrubberAnimationDx,
    this.circleSize = 0.5,
    this.borderWidth = 3,
    this.scrubberWidth = 1,
    this.showScrubber = true,
    this.borderPaintColor = Colors.white,
    this.circlePaintColor = Colors.white,
    this.scrubberPaintColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var borderPaint = Paint()
      ..color = borderPaintColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var horizintalBordersPaint = Paint()
      ..color = borderPaintColor
      // ..strokeWidth = borderWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var circlePaint = Paint()
      ..color = circlePaintColor
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var scrubberPaint = Paint()
      ..color = scrubberPaintColor
      ..strokeWidth = scrubberWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var linesPaint = Paint()
      ..color = scrubberPaintColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromPoints(startPos, endPos);

    final dragRectLeft = Rect.fromPoints(Offset(startPos.dx - 14, startPos.dy - 1.5), Offset(startPos.dx, endPos.dy + 1.5));
    final roundedRectLeft = RRect.fromRectAndCorners(
      dragRectLeft, 
      topLeft: Radius.circular(6), 
      bottomLeft: Radius.circular(6)
    );

    final dragRectRigth = Rect.fromPoints(Offset(endPos.dx, endPos.dy + 1.5), Offset(endPos.dx + 14, startPos.dy - 1.5));
    final roundedRectRigth = RRect.fromRectAndCorners(
      dragRectRigth, 
      topRight: Radius.circular(6), 
      bottomRight: Radius.circular(6)
    );

    canvas.drawRect(rect, borderPaint);

    canvas.drawRRect(roundedRectLeft, horizintalBordersPaint);
    canvas.drawLine(
      Offset(startPos.dx - 9.5, startPos.dy + (endPos.dy * 0.33)),
      Offset(startPos.dx - 9.5, endPos.dy - (endPos.dy * 0.33)),
      linesPaint,
    );
    canvas.drawLine(
      Offset(startPos.dx - 6.25, startPos.dy + (endPos.dy * 0.33)),
      Offset(startPos.dx - 6.25, endPos.dy - (endPos.dy * 0.33)),
      linesPaint,
    );
    canvas.drawLine(
      Offset(startPos.dx - 3, startPos.dy + (endPos.dy * 0.33)),
      Offset(startPos.dx - 3, endPos.dy - (endPos.dy * 0.33)),
      linesPaint,
    );

    canvas.drawRRect(roundedRectRigth, horizintalBordersPaint);
    canvas.drawLine(
      Offset(endPos.dx + 9.5, startPos.dy + (endPos.dy * 0.33)),
      Offset(endPos.dx + 9.5, endPos.dy - (endPos.dy * 0.33)),
      linesPaint,
    );
    canvas.drawLine(
      Offset(endPos.dx + 6.25, startPos.dy + (endPos.dy * 0.33)),
      Offset(endPos.dx + 6.25, endPos.dy - (endPos.dy * 0.33)),
      linesPaint,
    );
    canvas.drawLine(
      Offset(endPos.dx + 3, startPos.dy + (endPos.dy * 0.33)),
      Offset(endPos.dx + 3, endPos.dy - (endPos.dy * 0.33)),
      linesPaint,
    );
    if (showScrubber) {
      if (scrubberAnimationDx.toInt() > startPos.dx.toInt()) {
        canvas.drawLine(
          Offset(scrubberAnimationDx, -1),
          Offset(scrubberAnimationDx, 0) + Offset(0, endPos.dy + 1),
          scrubberPaint,
        );
      }
    }
    // canvas.drawCircle(
    //     startPos + Offset(0, endPos.dy / 2), circleSize, circlePaint);
    // canvas.drawCircle(
    //     endPos + Offset(0, -endPos.dy / 2), circleSize, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}