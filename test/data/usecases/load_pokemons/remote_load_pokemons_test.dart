@Timeout(Duration(seconds: 2))

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/domain/entities/entities.dart';

class RemoteLoadPokemons {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPokemons({@required this.httpClient, @required this.url});

  Future<List<PokemonResult>> load(int page) {
    httpClient.request(
        url: url, method: 'get', params: {'offset': page * 10, 'limit': 10});
  }
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteLoadPokemons sut;
  HttpClient httpClient;
  String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteLoadPokemons(httpClient: httpClient, url: url);
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
}
