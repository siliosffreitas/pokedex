import 'package:pokedex/data/usecases/load_pokemons/remote_load_pokemons.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/main/factories/http/api_url_factory.dart';
import 'package:pokedex/main/factories/http/http_client_factory.dart';

LoadPokemons makeRemoteLoadPokemons() {
  return RemoteLoadPokemons(
    url: makeApiUrl('pokemon'),
    httpClient: makeHttpAdapter(),
  );
}
