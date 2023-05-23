@Timeout(Duration(seconds: 2))

import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/pokemons/getx_pokemons_presenter.dart';

class LoadPokemonsSpy extends Mock implements LoadPokemons {}

main() {
  GetxPokemonsPresenter sut;
  LoadPokemons loadPokemons;

  setUp(() {
    loadPokemons = LoadPokemonsSpy();
    sut = GetxPokemonsPresenter(loadPokemons: loadPokemons);
  });

  test('Should call loadPokemons on loadData', () {
    sut.loadData();
    verify(loadPokemons.load(0)).called(1);
  });
}
