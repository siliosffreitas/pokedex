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

    test('Should return empty string if string is empty', () {
      final text = '';
      expect(capitalize(text), '');
    });

    test('Should return null string if string is null', () {
      final text = null;
      expect(capitalize(text), null);
    });
  });
}
