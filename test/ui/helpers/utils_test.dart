import 'package:pokedex/ui/helpers/utils.dart';
import 'package:test/test.dart';

void main() {
  group('captilize', () {
    test('Should captilize string', () {
      final text = 'pokemon name';
      expect(capitalize(text), 'Pokemon name');
    });
  });
}
