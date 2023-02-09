import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({required this.size});

  final Size size;

  double _currentProgress = 0.0;
  double _maxProgress = 1.0;

  void setCurrentProgress(double progress) {
    if (progress < 0.0) {
      _currentProgress = 0.0;
    } else if (progress > _maxProgress) {
      _currentProgress = _maxProgress;
    } else {
      _currentProgress = progress;
    }
  }

  void setMaxProgress(double newMax) {
    _maxProgress = newMax;
    setCurrentProgress(_currentProgress);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: ProgressPainter(progress: _currentProgress)
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({required this.progress});

  double progress;

  set setProgress(double p) {
    progress = p;
  }

  Color progressColor(double prog) {
    if (prog < 0.3) {
      return Colors.red;
    } else if (prog < 0.6) {
      return Colors.orange;
    } else if (prog < 1.0) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = progressColor(progress)
      ..style = PaintingStyle.fill;

    var undone = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    double fill = progress * size.width;

    // background rect
    canvas.drawRect(Offset(fill, 0) & Size((1.0 - progress) * size.width, size.height), undone);
    // filling rect
    canvas.drawRect(const Offset(0, 0) & Size(fill + 1, size.height), paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}