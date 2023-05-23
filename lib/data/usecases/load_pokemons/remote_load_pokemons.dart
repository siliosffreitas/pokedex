import 'package:meta/meta.dart';

import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/data/models/models.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/helpers.dart';
import 'package:pokedex/domain/usecases/usecases.dart';

class RemoteLoadPokemons implements LoadPokemons {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPokemons({
    @required this.httpClient,
    @required this.url,
  });

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
