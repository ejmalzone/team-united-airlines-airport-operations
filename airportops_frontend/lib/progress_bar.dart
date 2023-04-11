import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final Size size;

  ProgressBar({Key? key, required this.size}) : super(key: key);

  @override
  ProgressState createState() => ProgressState();
}

class ProgressState extends State<ProgressBar> {
  final _currentProgress = ValueNotifier<double>(0.0);
  double _maxProgress = 1.0;

  set currentProgress(double progress) {
    setState(() {
      if (progress < 0.0) {
        _currentProgress.value = 0.0;
      } else if (progress > _maxProgress) {
        _currentProgress.value = _maxProgress;
      } else {
        _currentProgress.value = progress;
      }
    });
  }

  void setMaxProgress(double newMax) {
    setState(() {
      _maxProgress = newMax;
      currentProgress = _currentProgress.value;
    });
  }

  double get currentProgress {
    return _currentProgress.value;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: widget.size, painter: ProgressPainter(repaint: _currentProgress));
  }
}

class ProgressPainter extends CustomPainter {
  final ValueNotifier<double> repaint;

  ProgressPainter({required this.repaint}) : super(repaint: repaint);

  Color progressColor(double prog) {
    if (prog < 0.3) {
      return Colors.red;
    } else if (prog < 0.6) {
      return Colors.orange;
    } else if (prog < .99) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = progressColor(repaint.value)
      ..style = PaintingStyle.fill;

    final undone = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    final fill = repaint.value * size.width;

    // background rect
    canvas.drawRect(
        Offset(fill, 0) & Size((1.0 - repaint.value) * size.width, size.height),
        undone);
    // filling rect
    canvas.drawRect(const Offset(0, 0) & Size(fill + 1, size.height), paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
