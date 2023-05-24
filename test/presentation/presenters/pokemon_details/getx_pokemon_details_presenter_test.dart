import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/pokemon_details/getx_pokemon_details_presenter.dart';
import 'package:test/test.dart';

class LoadPokemonDetailsSpy extends Mock implements LoadPokemonDetails {}

void main() {
  test('Should call loadPokemonDetails on loadData', () {
    final loadPokemonDetails = LoadPokemonDetailsSpy();
    final pokemonName = faker.lorem.word();
    final sut = GetxPokemonDetailsPresenter(
      loadPokemonDetails: loadPokemonDetails,
      pokemonName: pokemonName,
    );

    sut.loadData();
    verify(loadPokemonDetails.loadByPokemon(pokemonName)).called(1);
  });
}
