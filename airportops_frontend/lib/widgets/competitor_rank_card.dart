
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/competitor.dart';
import '../enums.dart';

class RankingCard extends StatelessWidget {
  var rank = -1;
  final Competitor competitor;

  RankingCard({super.key, required this.competitor});

  void setRank(int newRank) {
    rank = newRank + 1;
  }

  bool get isCSR {
    return competitor.position == Position.Csr;
  }

  double get grade {
    if (competitor.scanned != 0) {
      return (competitor.scanned.toDouble() - competitor.wrong.toDouble()) / competitor.scanned.toDouble();
    } else {
      return -1;
    }
  }

  bool get hasScans {
    return grade != 0;
  }

  Text get _letterGrade {
    if (competitor.scanned == 0) {
      return const Text('N', style: TextStyle(fontSize: 32, color: Colors.black38));
    }

    final g = grade;

    if (g == 1.0) {
      return const Text('S', style: TextStyle(fontSize: 32, color: Colors.greenAccent));
    } else if (g > 0.9) {
      return const Text('A', style: TextStyle(fontSize: 32, color: Colors.green));
    } else if (g > 0.8) {
      return const Text('B', style: TextStyle(fontSize: 32, color: Colors.lightGreenAccent));
    } else if (g > 0.7) {
      return const Text('C', style: TextStyle(fontSize: 32, color: Colors.yellow));
    } else if (g > 0.6) {
      return const Text('D', style: TextStyle(fontSize: 32, color: Colors.orange));
    } else {
      return const Text('F', style: TextStyle(fontSize: 32, color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    var ch = [
      _letterGrade,
      const SizedBox(width: 10),
      Flexible(child: Text('${competitor.firstname} ${competitor.lastname}', style: const TextStyle(fontSize: 24))),
      Text('  ${competitor.scanned - competitor.wrong}/${competitor.scanned}',
          style: TextStyle(fontSize: 22, color: (grade > 0.9) ? Colors.black : Colors.red))
    ];

    if (rank != -1) {
      ch.insert(0, Text('$rank.', style: const TextStyle(fontSize: 34, color: Colors.black54)));
      ch.insert(1, const SizedBox(width: 5));
    }

    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black12,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: ch,
        )
      ),
    );
  }
}
