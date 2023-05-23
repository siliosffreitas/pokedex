import 'package:meta/meta.dart';

import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/data/models/models.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/helpers.dart';

class RemoteLoadPokemonDetails {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPokemonDetails({
    @required this.httpClient,
    @required this.url,
  });

  Future<PokemonDetailsEntity> load(PokemonEntity pokemon) async {
    try {
      final httpResponse =
          await httpClient.request(url: '$url/${pokemon.name}', method: 'get');
      return RemotePokemonDetailsModel.fromJson(httpResponse).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
