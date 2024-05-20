class Helpers {
  static formatTwoDigits(int n) {
    if (n >= 10) {
      return n.toString();
    } else {
      return '0$n';
    }
  }
}
