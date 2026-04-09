class NumberFormatter {
  static String format(int number) {
    if (number < 1000) return number.toString();

    const suffixes = ['K', 'M', 'B'];
    double value = number.toDouble();
    int index = -1;

    while (value >= 1000 && index < suffixes.length - 1) {
      value /= 1000;
      index++;
    }

    final isInt = value == value.floor();

    return isInt
        ? '${value.toInt()}${suffixes[index]}'
        : '${value.toStringAsFixed(1)}${suffixes[index]}';
  }
}
