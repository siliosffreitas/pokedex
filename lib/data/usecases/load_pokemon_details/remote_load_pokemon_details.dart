import 'package:meta/meta.dart';

import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/domain/entities/entities.dart';

class RemoteLoadPokemonDetails {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPokemonDetails({
    @required this.httpClient,
    @required this.url,
  });

  Future<void> load(PokemonEntity pokemon) async {
    await httpClient.request(url: '$url/${pokemon.name}', method: 'get');
  }
}
