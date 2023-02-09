import 'package:flutter/cupertino.dart';

extension Capitalizer on String {
  String titleCase() {
    if (isEmpty) {
      return '';
    } else if (length == 1) {
      return toUpperCase();
    }

    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

// thank you stackoverflow https://stackoverflow.com/questions/52774921/space-between-columns-children-in-flutter/70993832#70993832
extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({double? width, double? height}) => [
    for (int i = 0; i < length; i++)
      ...[
        if (i > 0)
          SizedBox(width: width, height: height),
        this[i],
      ],
  ];
}
