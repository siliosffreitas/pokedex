import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/pokemon_details/getx_pokemon_details_presenter.dart';
import 'package:test/test.dart';

class LoadPokemonDetailsSpy extends Mock implements LoadPokemonDetails {}

void main() {
  GetxPokemonDetailsPresenter sut;
  LoadPokemonDetails loadPokemonDetails;
  String pokemonName;

  setUp(() {
    loadPokemonDetails = LoadPokemonDetailsSpy();
    pokemonName = faker.lorem.word();
    sut = GetxPokemonDetailsPresenter(
      loadPokemonDetails: loadPokemonDetails,
      pokemonName: pokemonName,
    );
  });

  test('Should call loadPokemonDetails on loadData', () {
    sut.loadData();
    verify(loadPokemonDetails.loadByPokemon(pokemonName)).called(1);
  });
}
