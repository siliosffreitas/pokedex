import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/data/usecases/load_pokemon_details/remote_load_pokemon_details.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient with correct values', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteLoadPokemonDetails(httpClient: httpClient, url: url);
    final pokemon = PokemonEntity(
      url: faker.internet.httpUrl(),
      name: faker.person.name(),
    );

    await sut.load(pokemon);
    verify(httpClient.request(
      url: '$url/${pokemon.name}',
      method: 'get',
    ));
  });
}
