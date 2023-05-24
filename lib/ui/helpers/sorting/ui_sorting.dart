enum UISorting { number, name }

extension UISortingExtension on UISorting {
  String get description {
    switch (this) {
      case UISorting.number:
        return 'Number';
      default:
        return 'Name';
    }
  }

  String get symbol {
    switch (this) {
      case UISorting.number:
        return '#';
      default:
        return 'A';
    }
  }
}
