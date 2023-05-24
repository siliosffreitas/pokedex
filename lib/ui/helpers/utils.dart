String capitalize(String s) {
  if (s?.isNotEmpty == true) {
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
  return s;
}
