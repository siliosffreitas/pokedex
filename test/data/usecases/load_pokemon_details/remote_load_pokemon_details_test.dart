import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/data/usecases/load_pokemon_details/remote_load_pokemon_details.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/helpers/helpers.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteLoadPokemonDetails sut;
  HttpClient httpClient;
  String url;
  PokemonEntity pokemon;
  Map list;

  Map mockValidData() => {
        "name": faker.person.name(),
        "id": faker.randomGenerator.integer(100),
        "sprites": {
          "other": {
            "home": {
              "front_default": faker.internet.httpUrl(),
            },
          },
        },
        "types": [
          {
            "slot": faker.randomGenerator.integer(100),
            "type": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "slot": faker.randomGenerator.integer(100),
            "type": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            }
          },
        ],
        "weight": faker.randomGenerator.integer(100),
        "height": faker.randomGenerator.integer(100),
        "abilities": [
          {
            "ability": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            },
            "is_hidden": faker.randomGenerator.boolean(),
            "slot": faker.randomGenerator.integer(100),
          },
          {
            "ability": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            },
            "is_hidden": faker.randomGenerator.boolean(),
            "slot": faker.randomGenerator.integer(100),
          },
        ],
        "stats": [
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "hp",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 1,
            "stat": {
              "name": "special-attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "special-defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "speed",
              "url": faker.internet.httpUrl(),
            }
          }
        ],
      };

  Map mockInvalidValidDataNoImage() => {
        "name": faker.person.name(),
        "id": faker.randomGenerator.integer(100),
        "sprites": {
          "invalid_key": 'invalid_value',
        },
        "types": [
          {
            "slot": faker.randomGenerator.integer(100),
            "type": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            }
          },
        ],
        "weight": faker.randomGenerator.integer(100),
        "height": faker.randomGenerator.integer(100),
        "abilities": [
          {
            "ability": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            },
            "is_hidden": faker.randomGenerator.boolean(),
            "slot": faker.randomGenerator.integer(100),
          },
        ],
        "stats": [
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "hp",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 1,
            "stat": {
              "name": "special-attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "special-defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "speed",
              "url": faker.internet.httpUrl(),
            }
          }
        ],
      };

  Map mockInValidDataInType() => {
        "name": faker.person.name(),
        "id": faker.randomGenerator.integer(100),
        "sprites": {
          "other": {
            "home": {
              "front_default": faker.internet.httpUrl(),
            },
          },
        },
        "types": [
          {
            "invalid_key": 'invalid_value',
          },
        ],
        "weight": faker.randomGenerator.integer(100),
        "height": faker.randomGenerator.integer(100),
        "abilities": [
          {
            "ability": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            },
            "is_hidden": faker.randomGenerator.boolean(),
            "slot": faker.randomGenerator.integer(100),
          },
        ],
        "stats": [
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "hp",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 1,
            "stat": {
              "name": "special-attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "special-defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "speed",
              "url": faker.internet.httpUrl(),
            }
          }
        ],
      };

  Map mockInValidDataInAbility() => {
        "name": faker.person.name(),
        "id": faker.randomGenerator.integer(100),
        "sprites": {
          "other": {
            "home": {
              "front_default": faker.internet.httpUrl(),
            },
          },
        },
        "types": [
          {
            "slot": faker.randomGenerator.integer(100),
            "type": {
              "name": faker.lorem.word(),
              "url": faker.internet.httpUrl(),
            }
          },
        ],
        "weight": faker.randomGenerator.integer(100),
        "height": faker.randomGenerator.integer(100),
        "abilities": [
          {
            "invalid_key": 'invalid_value',
          },
        ],
        "stats": [
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "hp",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 1,
            "stat": {
              "name": "special-attack",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "special-defense",
              "url": faker.internet.httpUrl(),
            }
          },
          {
            "base_stat": faker.randomGenerator.integer(100),
            "effort": 0,
            "stat": {
              "name": "speed",
              "url": faker.internet.httpUrl(),
            }
          }
        ],
      };

  PostExpectation mockRequest() => when(
      httpClient.request(url: anyNamed('url'), method: anyNamed('method')));

  void mockHttpData(Map data) {
    list = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteLoadPokemonDetails(httpClient: httpClient, url: url);
    pokemon = PokemonEntity(
      url: faker.internet.httpUrl(),
      name: faker.person.name(),
    );

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load(pokemon);
    verify(httpClient.request(
      url: '$url/${pokemon.name}',
      method: 'get',
    ));
  });

  test('Should return details on 200', () async {
    final details = await sut.load(pokemon);

    expect(
      details,
      PokemonDetailsEntity(
        name: list['name'],
        id: list['id'],
        urlPhoto: list['sprites']['other']['home']['front_default'],
        types: [
          TypeEntity(
            name: list['types'][0]['type']['name'],
            order: list['types'][0]['slot'],
          ),
          TypeEntity(
            name: list['types'][1]['type']['name'],
            order: list['types'][1]['slot'],
          ),
        ],
        weight: list['weight'],
        height: list['height'],
        abilities: [
          AbilityEntity(name: list['abilities'][0]['ability']['name']),
          AbilityEntity(name: list['abilities'][1]['ability']['name']),
        ],
        hp: list['stats'][0]['base_stat'],
        attack: list['stats'][1]['base_stat'],
        defense: list['stats'][2]['base_stat'],
        specialAttack: list['stats'][3]['base_stat'],
        specialDefense: list['stats'][4]['base_stat'],
        speed: list['stats'][5]['base_stat'],
      ),
    );
  });

  test(
      'Should throw UnexpectedError if httpclient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.load(pokemon);

    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw UnexpectedError if httpclient returns 200 with invalid data, no image',
      () async {
    mockHttpData(mockInvalidValidDataNoImage());

    final future = sut.load(pokemon);

    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw UnexpectedError if httpclient returns 200 with invalid data in type',
      () async {
    mockHttpData(mockInValidDataInType());

    final future = sut.load(pokemon);

    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw UnexpectedError if httpclient returns 200 with invalid data in ability',
      () async {
    mockHttpData(mockInValidDataInAbility());

    final future = sut.load(pokemon);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if httpclient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.load(pokemon);

    expect(future, throwsA(DomainError.unexpected));
  });
}
