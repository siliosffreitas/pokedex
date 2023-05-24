import 'package:meta/meta.dart';

import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/data/models/models.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/helpers.dart';
import 'package:pokedex/domain/usecases/usecases.dart';

class RemoteLoadPokemonDetails implements LoadPokemonDetails {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPokemonDetails({
    @required this.httpClient,
    @required this.url,
  });

  Future<PokemonDetailsEntity> loadByPokemon(String pokemonName) async {
    try {
      final httpResponse =
          await httpClient.request(url: '$url/$pokemonName', method: 'get');
      return RemotePokemonDetailsModel.fromJson(httpResponse).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
