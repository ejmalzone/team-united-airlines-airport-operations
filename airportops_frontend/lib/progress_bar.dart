import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
    required this.size
  });

  final Size size;

  @override
  State<ProgressBar> createState() {
    return ProgressBarState(size: size);
  }
}

class ProgressBarState extends State<ProgressBar> {
  ProgressBarState({required this.size});

  final Size size;

  double _currentProgress = 0.0;
  double _maxProgress = 1.0;

  void setCurrentProgress(double progress) {
    setState(() {
      if (progress < 0.0) {
        _currentProgress = 0.0;
      } else if (progress > _maxProgress) {
        _currentProgress = _maxProgress;
      } else {
        _currentProgress = progress;
      }
    });
  }

  void setMaxProgress(double newMax) {
    setState(() {
      _maxProgress = newMax;
      setCurrentProgress(_currentProgress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: ProgressPainter(state: this)
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({required this.state});

  final ProgressBarState state;

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
    var progress = state._currentProgress / state._maxProgress;

    var paint1 = Paint()
      ..color = progressColor(state._currentProgress)
      ..style = PaintingStyle.fill;

    var undone = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    double fill = state._currentProgress * size.width;

    // background rect
    canvas.drawRect(Offset(fill, 0) & Size((1.0 - progress) * size.width, size.height), undone);
    // filling rect
    canvas.drawRect(const Offset(0, 0) & Size(fill + 1, size.height), paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}