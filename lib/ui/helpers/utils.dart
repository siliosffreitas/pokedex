String capitalize(String s) {
  if (s?.isNotEmpty == true) {
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
  return s;
}

String format3Digits(num n) {
  if (n == null) {
    return null;
  }
  var a = n.toString().padLeft(3, '0');
  return a;
}
