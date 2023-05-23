import 'package:pokedex/data/usecases/load_pokemon_details/remote_load_pokemon_details.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/main/factories/http/api_url_factory.dart';
import 'package:pokedex/main/factories/http/http_client_factory.dart';

LoadPokemonDetails makeRemoteLoadPokemonDetails() {
  return RemoteLoadPokemonDetails(
    url: makeApiUrl('pokemon'),
    httpClient: makeHttpAdapter(),
  );
}
