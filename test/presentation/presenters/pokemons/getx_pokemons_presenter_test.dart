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

  PokemonDetailsEntity mockValidDataDetails() => PokemonDetailsEntity(
        name: 'nidoqueen',
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

  void mockLoadPokemons(PokemonResultEntity data) {
    pokemons = data;
    when(loadPokemons.load(any)).thenAnswer((_) async => data);
  }

  void mockLoadPokemonDetails(PokemonDetailsEntity data) {
    details = data;
    when(loadPokemonDetails.loadByPokemon(any)).thenAnswer((_) async => data);
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
    mockLoadPokemonDetails(mockValidDataDetails());
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
              ),
              'Nidoking': PokemonDetailsViewModel(
                name: 'Nidoqueen',
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
  });
}
