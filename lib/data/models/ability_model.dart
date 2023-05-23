import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

class AbilityModel {
  final String name;

  AbilityModel({
    @required this.name,
  });

  factory AbilityModel.fromJson(Map json) {
    return AbilityModel(
      name: json['ability']['name'],
    );
  }

  AbilityEntity toEntity() => AbilityEntity(name: name);
}
