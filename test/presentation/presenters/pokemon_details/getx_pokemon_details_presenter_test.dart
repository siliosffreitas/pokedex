@Timeout(Duration(seconds: 2))

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/helpers.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/pokemon_details/getx_pokemon_details_presenter.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';
import 'package:test/test.dart';

class LoadPokemonDetailsSpy extends Mock implements LoadPokemonDetails {}

void main() {
  GetxPokemonDetailsPresenter sut;
  LoadPokemonDetails loadPokemonDetails;
  String pokemonName;
  PokemonDetailsEntity details;

  PokemonDetailsEntity mockValidDataDetails() => PokemonDetailsEntity(
        name: faker.lorem.word(),
        id: 1,
        urlPhoto: faker.internet.httpUrl(),
        types: [
          TypeEntity(
            name: faker.person.name(),
            order: faker.randomGenerator.integer(100),
          ),
          TypeEntity(
            name: faker.person.name(),
            order: faker.randomGenerator.integer(100),
          ),
        ],
        weight: 34,
        height: 7,
        abilities: [
          AbilityEntity(name: faker.person.name()),
          AbilityEntity(name: faker.person.name()),
        ],
        hp: 20,
        attack: 30,
        defense: 40,
        specialAttack: 50,
        specialDefense: 60,
        speed: 70,
      );

  void mockLoadPokemonDetails(PokemonDetailsEntity data) {
    details = data;
    when(loadPokemonDetails.loadByPokemon(any)).thenAnswer((_) async => data);
  }

  void mockLoadDetailsError() => when(loadPokemonDetails.loadByPokemon(any))
      .thenThrow(DomainError.unexpected);

  setUp(() {
    loadPokemonDetails = LoadPokemonDetailsSpy();
    pokemonName = faker.lorem.word();
    sut = GetxPokemonDetailsPresenter(
      loadPokemonDetails: loadPokemonDetails,
      pokemonName: pokemonName,
    );
    mockLoadPokemonDetails(mockValidDataDetails());
  });

  test('Should call loadPokemonDetails on loadData', () {
    sut.loadData();
    verify(loadPokemonDetails.loadByPokemon(pokemonName)).called(1);
  });

  test('Should emit correct events on success', () {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.pokemonDetailsStream.listen(expectAsync1((pokemonsReturned) => expect(
        pokemonsReturned,
        PokemonDetailsViewModel(
          name: details.name,
          id: '#001',
          urlPhoto: details.urlPhoto,
          types: [
            TypeViewModel(
              order: details.types[0].order,
              name: details.types[0].name,
            ),
            TypeViewModel(
              order: details.types[1].order,
              name: details.types[1].name,
            ),
          ],
          weight: '3,4 kg',
          height: '0,7 m',
          abilities: [
            AbilityViewModel(name: details.abilities[0].name),
            AbilityViewModel(name: details.abilities[1].name),
          ],
          hp: '020',
          attack: '030',
          defense: '040',
          specialAttack: '050',
          specialDefense: '060',
          speed: '070',
        ))));
    sut.loadData();
  });

  test('Should emit correct events on details failure', () {
    mockLoadDetailsError();
    sut.pokemonDetailsStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));
    sut.loadData();
  });
}
