import 'package:pokedex/ui/helpers/utils.dart';
import 'package:test/test.dart';

void main() {
  group('captilize', () {
    test('Should captilize string', () {
      final text = 'pokemon name';
      expect(capitalize(text), 'Pokemon name');
    });

    test('Should captilize string in upper case', () {
      final text = 'POKEMON NAME';
      expect(capitalize(text), 'Pokemon name');
    });

    test('Should captilize string with one character', () {
      final text = 'p';
      expect(capitalize(text), 'P');
    });

    test('Should captilize string in upper case with one character', () {
      final text = 'P';
      expect(capitalize(text), 'P');
    });

    test('Should return empty string if string is empty', () {
      final text = '';
      expect(capitalize(text), '');
    });

    test('Should return null string if string is null', () {
      final text = null;
      expect(capitalize(text), null);
    });
  });

  group('format3Digits', () {
    test('Should format number', () {
      expect(format3Digits(2), '002');
    });
    test('Should format number 2 digits', () {
      expect(format3Digits(20), '020');
    });

    test('Should format number 3 digits', () {
      expect(format3Digits(200), '200');
    });

    test('Should format number 4 digits', () {
      expect(format3Digits(2000), '2000');
    });

    test('Should return null if number is null', () {
      expect(format3Digits(null), isNull);
    });
  });
}
