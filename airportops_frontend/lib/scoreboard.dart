import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/widgets/competitor_rank_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'classes/events.dart';

class ScoreboardRoute extends StatefulWidget {
  final Event event;

  const ScoreboardRoute({super.key, required this.event});

  @override
  State<StatefulWidget> createState() => _ScoreboardRouteState();
}

class _ScoreboardRouteState extends State<ScoreboardRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/kisspng-logo-brand-font-airline-logo-5b1d7561d2b990.7344765815286572498631.png',
          fit: BoxFit.contain,
          height: 80
        ),
        centerTitle: true
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10.0),
          const Center(child: Text('Scoreboard', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Customer Service', style: TextStyle(fontSize: 32)),
              Text('Ramp Service', style: TextStyle(fontSize: 32)),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 5,
            indent: 10,
            endIndent: 10,
            color: Colors.black
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScoreboardWidget(event: widget.event, kind: Position.Csr),
                ScoreboardWidget(event: widget.event, kind: Position.Ramp)
              ],
            )
          )
        ]
      )
    );
  }
}

class ScoreboardWidget extends StatefulWidget {
  final Event event;
  final Position kind;

  const ScoreboardWidget({Key? key, required this.event, required this.kind}) : super(key: key);

  @override
  State<ScoreboardWidget> createState() => _ScoreboardWidgetState();
}

class _ScoreboardWidgetState extends State<ScoreboardWidget> {
  @override
  Widget build(BuildContext context) {
    final comps = widget.event.competitors
        .map((e) => RankingCard(competitor: e))
        .where((element) => element.competitor.position == widget.kind)
        .toList();
    // sort them by their grade
    comps.sort((a, b) => a.grade.compareTo(b.grade));

    // assign ranks to the display
    for (var i = 0; i < comps.length; i++) {
      comps[i].setRank(i);
    }

    return Expanded(child:
        ListView(
          scrollDirection: Axis.vertical,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // insert spacing between elements
          children: comps.withSpaceBetween(height: 5)
        )
    );
  }
}
