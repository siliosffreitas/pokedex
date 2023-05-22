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
    httpClient
        .request(url: url, method: 'get', params: {'offset': 0, 'limit': 10});
  }
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient with correct values', () async {
    HttpClient httpClient = HttpClientSpy();
    String url = faker.internet.httpUrl();
    RemoteLoadPokemons sut =
        RemoteLoadPokemons(httpClient: httpClient, url: url);

    await sut.load(0);

    verify(httpClient
        .request(url: url, method: 'get', params: {'offset': 0, 'limit': 10}));
  });
}
