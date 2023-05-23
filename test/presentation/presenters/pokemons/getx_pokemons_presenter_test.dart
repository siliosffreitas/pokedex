@Timeout(Duration(seconds: 2))

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/pokemons/getx_pokemons_presenter.dart';
import 'package:pokedex/ui/pages/pokemons/pokemon_result_view_model.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class LoadPokemonsSpy extends Mock implements LoadPokemons {}

main() {
  GetxPokemonsPresenter sut;
  LoadPokemons loadPokemons;
  PokemonResultEntity pokemons;

  PokemonResultEntity mockValidData() => PokemonResultEntity(
        total: faker.randomGenerator.integer(100),
        pokemons: [
          PokemonEntity(
            url: faker.internet.httpUrl(),
            name: faker.person.name(),
          ),
          PokemonEntity(
            url: faker.internet.httpUrl(),
            name: faker.person.name(),
          ),
        ],
      );

  void mockLoadSurveys(PokemonResultEntity data) {
    pokemons = data;
    when(loadPokemons.load(any)).thenAnswer((_) async => data);
  }

  setUp(() {
    loadPokemons = LoadPokemonsSpy();
    sut = GetxPokemonsPresenter(loadPokemons: loadPokemons);
    mockLoadSurveys(mockValidData());
  });

  test('Should call loadPokemons on loadData', () {
    sut.loadData();
    verify(loadPokemons.load(0)).called(1);
  });

  test('Should emit correct events on success', () {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
        pokemonsReturned,
        PokemonsResultViewModel(pokemons: [
          PokemonViewModel(
            url: pokemons.pokemons[0].url,
            name: pokemons.pokemons[0].name,
            id: null,
          ),
          PokemonViewModel(
            url: pokemons.pokemons[1].url,
            name: pokemons.pokemons[1].name,
            id: null,
          ),
        ]))));
    sut.loadData();
  });
}
