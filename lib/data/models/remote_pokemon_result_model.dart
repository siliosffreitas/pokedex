import 'package:meta/meta.dart';
import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/data/models/models.dart';
import 'package:pokedex/domain/entities/entities.dart';

class RemotePokemonResultModel {
  final int count;
  final List<RemotePokemonModel> results;

  RemotePokemonResultModel({
    @required this.count,
    @required this.results,
  });

  factory RemotePokemonResultModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['count', 'results'])) {
      throw HttpError.invalidData;
    }
    return RemotePokemonResultModel(
        count: json['count'],
        results: json['results']
            .map<RemotePokemonModel>(
                (pokemonJson) => RemotePokemonModel.fromJson(pokemonJson))
            .toList());
  }

  PokemonResultEntity toEntity() => PokemonResultEntity(
        total: count,
        pokemons: results.map((model) => model.toEntity()).toList(),
      );
}
