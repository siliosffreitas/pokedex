import 'package:meta/meta.dart';
import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/domain/entities/entities.dart';

class RemotePokemonModel {
  final String name;
  final String url;

  RemotePokemonModel({
    @required this.name,
    @required this.url,
  });

  factory RemotePokemonModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['name', 'url'])) {
      throw HttpError.invalidData;
    }
    return RemotePokemonModel(
      name: json['name'],
      url: json['url'],
    );
  }

  PokemonEntity toEntity() => PokemonEntity(
        name: name,
        url: url,
      );
}
