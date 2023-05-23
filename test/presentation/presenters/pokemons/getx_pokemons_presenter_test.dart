@Timeout(Duration(seconds: 2))

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/helpers.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/pokemons/getx_pokemons_presenter.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

class LoadPokemonsSpy extends Mock implements LoadPokemons {}

class LoadPokemonDetailsSpy extends Mock implements LoadPokemonDetails {}

main() {
  GetxPokemonsPresenter sut;
  LoadPokemons loadPokemons;
  LoadPokemonDetails loadPokemonDetails;
  PokemonResultEntity pokemons;
  PokemonDetailsEntity details;

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

  PokemonDetailsEntity mockValidDataDetails() => PokemonDetailsEntity(
        name: faker.person.name(),
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
        weight: faker.randomGenerator.integer(100),
        height: faker.randomGenerator.integer(100),
        abilities: [
          AbilityEntity(name: faker.person.name()),
          AbilityEntity(name: faker.person.name()),
        ],
        hp: faker.randomGenerator.integer(100),
        attack: faker.randomGenerator.integer(100),
        defense: faker.randomGenerator.integer(100),
        specialAttack: faker.randomGenerator.integer(100),
        specialDefense: faker.randomGenerator.integer(100),
        speed: faker.randomGenerator.integer(100),
      );

  void mockLoadPokemons(PokemonResultEntity data) {
    pokemons = data;
    when(loadPokemons.load(any)).thenAnswer((_) async => data);
  }

  void mockLoadPokemonDetails(PokemonDetailsEntity data) {
    details = data;
    when(loadPokemonDetails.load(any)).thenAnswer((_) async => data);
  }

  void mockLoadPokemonsError() =>
      when(loadPokemons.load(any)).thenThrow(DomainError.unexpected);

  void mockLoadDetailsError() =>
      when(loadPokemonDetails.load(any)).thenThrow(DomainError.unexpected);

  setUp(() {
    loadPokemons = LoadPokemonsSpy();
    loadPokemonDetails = LoadPokemonDetailsSpy();
    sut = GetxPokemonsPresenter(
      loadPokemons: loadPokemons,
      loadPokemonDetails: loadPokemonDetails,
    );
    mockLoadPokemons(mockValidData());
    mockLoadPokemonDetails(mockValidDataDetails());
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

  test('Should emit correct events on failure', () {
    mockLoadPokemonsError();
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.pokemonsStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));
    sut.loadData();
  });

  test('Should go to PokemonDetailsPage on pokemon click', () {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/pokemon/any_route')));

    sut.goToPokemonDetail('any_route');
  });

  test('Should change page in second call', () async {
    await sut.loadData();
    verify(loadPokemons.load(0)).called(1);

    await sut.loadData();
    verify(loadPokemons.load(1)).called(1);

    await sut.loadData();
    verify(loadPokemons.load(2)).called(1);
  });

  test('Should append result in second page', () async {
    await sut.loadData();
    sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
          pokemonsReturned,
          PokemonsResultViewModel(
            pokemons: [
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
            ],
          ),
        )));

    await sut.loadData();
  });

  test('Should call loadPokemonDetails on pokemon load', () {
    sut.loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]));
    verify(loadPokemonDetails.load(pokemons.pokemons[0])).called(1);
  });

  test('Should emit correct events on details success', () {
    sut.pokemonDetailsStream.listen(expectAsync1(
        (pokemonsDetailsReturned) => expect(pokemonsDetailsReturned, {
              pokemons.pokemons[0].name: PokemonDetailsViewModel(
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
                weight: details.weight,
                height: details.height,
                abilities: [
                  AbilityViewModel(name: details.abilities[0].name),
                  AbilityViewModel(name: details.abilities[1].name),
                ],
                hp: details.hp,
                attack: details.attack,
                defense: details.defense,
                specialAttack: details.specialAttack,
                specialDefense: details.specialDefense,
                speed: details.speed,
              )
            })));
    sut.loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]));
  });

  test('Should emit correct events on details failure', () {
    mockLoadDetailsError();
    sut.pokemonDetailsStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));
    sut.loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]));
  });
}
