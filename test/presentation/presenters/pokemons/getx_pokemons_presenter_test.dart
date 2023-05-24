@Timeout(Duration(seconds: 2))

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/helpers.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/pokemons/getx_pokemons_presenter.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

class LoadPokemonsSpy extends Mock implements LoadPokemons {}

class LoadPokemonDetailsSpy extends Mock implements LoadPokemonDetails {}

main() {
  GetxPokemonsPresenter sut;
  LoadPokemons loadPokemons;
  LoadPokemonDetails loadPokemonDetails;
  PokemonResultEntity pokemons;
  String search;

  PokemonResultEntity mockValidData() => PokemonResultEntity(
        total: faker.randomGenerator.integer(100),
        pokemons: [
          PokemonEntity(
            url: faker.internet.httpUrl(),
            name: 'nidoqueen',
          ),
          PokemonEntity(
            url: faker.internet.httpUrl(),
            name: 'nidoking',
          ),
        ],
      );

  PokemonDetailsEntity mockValidDataDetails1() => PokemonDetailsEntity(
        name: 'nidoking',
        id: 1,
        urlPhoto: 'http://www.image/1',
        types: [
          TypeEntity(
            name: 'type_1_0',
            order: 0,
          ),
          TypeEntity(
            name: 'type_1_1',
            order: 1,
          ),
        ],
        weight: 34,
        height: 7,
        abilities: [
          AbilityEntity(name: 'ability_1_0'),
          AbilityEntity(name: 'ability_1_1'),
        ],
        hp: 20,
        attack: 30,
        defense: 40,
        specialAttack: 50,
        specialDefense: 60,
        speed: 70,
      );

  PokemonDetailsEntity mockValidDataDetails2() => PokemonDetailsEntity(
        name: 'nidoqueen',
        id: 2,
        urlPhoto: 'http://www.image/2',
        types: [
          TypeEntity(
            name: 'type_2_0',
            order: 0,
          ),
          TypeEntity(
            name: 'type_2_1',
            order: 1,
          ),
        ],
        weight: 34,
        height: 7,
        abilities: [
          AbilityEntity(
            name: 'ability_2_0',
          ),
          AbilityEntity(name: 'ability_2_1'),
        ],
        hp: 20,
        attack: 30,
        defense: 40,
        specialAttack: 50,
        specialDefense: 60,
        speed: 70,
      );

  void mockLoadPokemons(PokemonResultEntity data) {
    pokemons = data;
    when(loadPokemons.load(any)).thenAnswer((_) async => data);
  }

  void mockLoadPokemonDetails() {
    when(loadPokemonDetails.loadByPokemon('nidoqueen')).thenAnswer((_) async {
      return mockValidDataDetails2();
    });
    when(loadPokemonDetails.loadByPokemon('nidoking')).thenAnswer((_) async {
      return mockValidDataDetails1();
    });
  }

  void mockLoadPokemonsError() =>
      when(loadPokemons.load(any)).thenThrow(DomainError.unexpected);

  void mockLoadDetailsError() => when(loadPokemonDetails.loadByPokemon(any))
      .thenThrow(DomainError.unexpected);

  setUp(() {
    loadPokemons = LoadPokemonsSpy();
    loadPokemonDetails = LoadPokemonDetailsSpy();
    sut = GetxPokemonsPresenter(
      loadPokemons: loadPokemons,
      loadPokemonDetails: loadPokemonDetails,
    );
    mockLoadPokemons(mockValidData());
    mockLoadPokemonDetails();
    search = faker.lorem.word();
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
            name: 'Nidoqueen',
            id: null,
          ),
          PokemonViewModel(
            url: pokemons.pokemons[1].url,
            name: 'Nidoking',
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
    expectLater(
        sut.navigateToStream, emitsInOrder([null, '/pokemon/any_route']));

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
                name: 'Nidoqueen',
                id: null,
              ),
              PokemonViewModel(
                url: pokemons.pokemons[1].url,
                name: 'Nidoking',
                id: null,
              ),
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
              PokemonViewModel(
                url: pokemons.pokemons[1].url,
                name: 'Nidoking',
                id: null,
              ),
            ],
          ),
        )));

    await sut.loadData();
  });

  test('Should call loadPokemonDetails on pokemon load', () {
    sut.loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]).name);
    verify(loadPokemonDetails.loadByPokemon(pokemons.pokemons[0].name))
        .called(1);
  });

  test('Should emit correct events on details success', () {
    sut.pokemonDetailsStream.listen(expectAsync1(
        (pokemonsDetailsReturned) => expect(pokemonsDetailsReturned, {
              'Nidoqueen': PokemonDetailsViewModel(
                name: 'Nidoqueen',
                id: '#002',
                urlPhoto: 'http://www.image/2',
                types: [
                  TypeViewModel(
                    order: 0,
                    name: 'type_2_0',
                  ),
                  TypeViewModel(
                    order: 1,
                    name: 'type_2_1',
                  ),
                ],
                weight: '3,4 kg',
                height: '0,7 m',
                abilities: [
                  AbilityViewModel(name: 'ability_2_0'),
                  AbilityViewModel(name: 'ability_2_1'),
                ],
                hp: '020',
                attack: '030',
                defense: '040',
                specialAttack: '050',
                specialDefense: '060',
                speed: '070',
              )
            })));
    sut.loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]).name);
  });

  test('Should emit correct events on details failure', () {
    mockLoadDetailsError();
    sut.pokemonDetailsStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));
    sut.loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]).name);
  });

  test('Should mantain previous details if receive new details', () async {
    await sut
        .loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]).name);

    sut.pokemonDetailsStream.listen(expectAsync1(
        (pokemonsDetailsReturned) => expect(pokemonsDetailsReturned, {
              'Nidoqueen': PokemonDetailsViewModel(
                name: 'Nidoqueen',
                id: '#002',
                urlPhoto: 'http://www.image/2',
                types: [
                  TypeViewModel(
                    order: 0,
                    name: 'type_2_0',
                  ),
                  TypeViewModel(
                    order: 1,
                    name: 'type_2_1',
                  ),
                ],
                weight: '3,4 kg',
                height: '0,7 m',
                abilities: [
                  AbilityViewModel(name: 'ability_2_0'),
                  AbilityViewModel(name: 'ability_2_1'),
                ],
                hp: '020',
                attack: '030',
                defense: '040',
                specialAttack: '050',
                specialDefense: '060',
                speed: '070',
              ),
              'Nidoking': PokemonDetailsViewModel(
                name: 'Nidoking',
                id: '#001',
                urlPhoto: 'http://www.image/1',
                types: [
                  TypeViewModel(
                    order: 0,
                    name: 'type_1_0',
                  ),
                  TypeViewModel(
                    order: 1,
                    name: 'type_1_1',
                  ),
                ],
                weight: '3,4 kg',
                height: '0,7 m',
                abilities: [
                  AbilityViewModel(name: 'ability_1_0'),
                  AbilityViewModel(name: 'ability_1_1'),
                ],
                hp: '020',
                attack: '030',
                defense: '040',
                specialAttack: '050',
                specialDefense: '060',
                speed: '070',
              ),
            })));
    await sut
        .loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[1]).name);
  });

  group('search', () {
    test('Should show X button if search is inputed or not', () async {
      await sut.loadData();
      expectLater(sut.searchStream, emitsInOrder([search, null, search, '']));
      sut.search(search);
      sut.search(null);
      sut.search(search);
      sut.search('');
    });

    test('Should clear search on call clearSearch', () async {
      await sut.loadData();
      expectLater(sut.searchStream, emitsInOrder([search, null, '', null]));
      sut.search(search);
      sut.clearSearch();
      sut.search('');
      sut.clearSearch();
    });

    group('by name', () {
      test('Should return only pokemons that matchs in name', () async {
        await sut.loadData();

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
            ]))));
        sut.search('Nidoqueen');
      });

      test('Should return empty list if none founded', () async {
        await sut.loadData();

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) =>
            expect(pokemonsReturned, PokemonsResultViewModel(pokemons: []))));
        sut.search('no_pokemon_name');
      });

      test('Should return only pokemons that partial matchs in name', () async {
        await sut.loadData();

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
            ]))));
        sut.search('Nidoq');
      });

      test(
          'Should return only pokemons that partial matchs in name ignoring case',
          () async {
        await sut.loadData();

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
            ]))));
        sut.search('nidoq');
      });

      test('Should return all pokemons search is null', () async {
        await sut.loadData();
        sut.search('Nidoqueen');

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
              PokemonViewModel(
                url: pokemons.pokemons[1].url,
                name: 'Nidoking',
                id: null,
              ),
            ]))));
        sut.search(null);
      });

      test('Should return all pokemons search is after filter', () async {
        await sut.loadData();
        sut.search('Nidoqueen');

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
              PokemonViewModel(
                url: pokemons.pokemons[1].url,
                name: 'Nidoking',
                id: null,
              ),
            ]))));
        sut.search('Nido');
      });

      test('Should return all pokemons search is empty', () async {
        await sut.loadData();
        sut.search('Nidoqueen');

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
              PokemonViewModel(
                url: pokemons.pokemons[1].url,
                name: 'Nidoking',
                id: null,
              ),
            ]))));
        sut.search('');
      });

      test('Should return all pokemons when clear search', () async {
        await sut.loadData();
        sut.search('Nidoqueen');

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
              PokemonViewModel(
                url: pokemons.pokemons[1].url,
                name: 'Nidoking',
                id: null,
              ),
            ]))));
        sut.clearSearch();
      });
    });

    group('by code', () {
      test('Should return only pokemons that matchs in code', () async {
        await sut.loadData();
        await sut.loadDetails(
            PokemonViewModel.fromEntity(pokemons.pokemons[0]).name);

        sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
            pokemonsReturned,
            PokemonsResultViewModel(pokemons: [
              PokemonViewModel(
                url: pokemons.pokemons[0].url,
                name: 'Nidoqueen',
                id: null,
              ),
            ]))));
        sut.search('002');
      });
    });
  });

  group('sorting', () {
    test('Should go to SortingModal on sorting click', () {
      expectLater(sut.navigateToStream, emitsInOrder([null, '/modal_sorting']));

      sut.goToChangeSorting();
    });

    test('Should change sorting on option click', () async {
      await sut.loadData();
      expectLater(sut.sortingStream,
          emitsInOrder([UISorting.number, UISorting.name, UISorting.number]));

      sut.changeSorting(UISorting.number);
      sut.changeSorting(UISorting.name);
      sut.changeSorting(UISorting.number);
    });

    test('Should sort by name', () async {
      await sut.loadData();

      sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
          pokemonsReturned,
          PokemonsResultViewModel(pokemons: [
            PokemonViewModel(
              url: pokemons.pokemons[1].url,
              name: 'Nidoking',
              id: null,
            ),
            PokemonViewModel(
              url: pokemons.pokemons[0].url,
              name: 'Nidoqueen',
              id: null,
            ),
          ]))));

      sut.changeSorting(UISorting.name);
    });

    test('Should sort by code', () async {
      await sut.loadData();
      await sut
          .loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[0]).name);
      await sut
          .loadDetails(PokemonViewModel.fromEntity(pokemons.pokemons[1]).name);

      sut.pokemonsStream.listen(expectAsync1((pokemonsReturned) => expect(
          pokemonsReturned,
          PokemonsResultViewModel(pokemons: [
            PokemonViewModel(
              url: pokemons.pokemons[1].url,
              name: 'Nidoking',
              id: null,
            ),
            PokemonViewModel(
              url: pokemons.pokemons[0].url,
              name: 'Nidoqueen',
              id: null,
            ),
          ]))));

      sut.changeSorting(UISorting.number);
    });
  });
}
