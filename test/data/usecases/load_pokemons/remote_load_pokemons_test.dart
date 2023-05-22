@Timeout(Duration(seconds: 2))

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/data/models/models.dart';
import 'package:pokedex/domain/helpers/helpers.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/domain/entities/entities.dart';

class RemoteLoadPokemons {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPokemons({@required this.httpClient, @required this.url});

  Future<PokemonResultEntity> load(int page) async {
    try {
      final httpResponse = await httpClient.request(
          url: url, method: 'get', params: {'offset': page * 10, 'limit': 10});
      return RemotePokemonResultModel.fromJson(httpResponse).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteLoadPokemons sut;
  HttpClient httpClient;
  String url;
  Map list;

  Map mockValidData() => {
        "count": faker.randomGenerator.integer(1000),
        "next": faker.internet.httpUrl(),
        "previous": faker.internet.httpUrl(),
        "results": [
          {
            "name": faker.randomGenerator.string(10),
            "url": faker.internet.httpUrl(),
          },
          {
            "name": faker.randomGenerator.string(10),
            "url": faker.internet.httpUrl(),
          },
        ]
      };

  PostExpectation mockRequest() => when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      params: anyNamed('params')));

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
    sut = RemoteLoadPokemons(httpClient: httpClient, url: url);

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load(0);
    verify(httpClient
        .request(url: url, method: 'get', params: {'offset': 0, 'limit': 10}));
  });

  test('Should call HttpClient with correct values in second page', () async {
    await sut.load(1);

    verify(httpClient
        .request(url: url, method: 'get', params: {'offset': 10, 'limit': 10}));
  });

  test('Should return pokemons on 200', () async {
    final pokemons = await sut.load(0);

    expect(
      pokemons,
      PokemonResultEntity(
        total: list['count'],
        pokemons: [
          PokemonEntity(
            name: list['results'][0]['name'],
            url: list['results'][0]['url'],
          ),
          PokemonEntity(
            name: list['results'][1]['name'],
            url: list['results'][1]['url'],
          ),
        ],
      ),
    );
  });

  test(
      'Should throw UnexpectedError if httpclient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.load(0);

    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw UnexpectedError if httpclient returns 200 with invalid data in pokemon',
      () async {
    mockHttpData({
      'count': 1,
      "results": [
        {'invalid_key': 'invalid_value'},
      ]
    });

    final future = sut.load(0);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if httpclient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.load(0);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if httpclient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.load(0);

    expect(future, throwsA(DomainError.unexpected));
  });
}
