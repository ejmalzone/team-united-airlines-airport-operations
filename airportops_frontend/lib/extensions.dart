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