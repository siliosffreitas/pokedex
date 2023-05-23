import 'package:meta/meta.dart';
import 'package:pokedex/data/models/models.dart';
import 'package:pokedex/domain/entities/entities.dart';

class RemotePokemonDetailsModel {
  final String name;
  final int id;
  final String urlPhoto;
  final List<TypeModel> types;
  final int weight;
  final int height;
  final List<AbilityModel> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  RemotePokemonDetailsModel({
    @required this.name,
    @required this.id,
    @required this.urlPhoto,
    @required this.types,
    @required this.weight,
    @required this.height,
    @required this.abilities,
    @required this.hp,
    @required this.attack,
    @required this.defense,
    @required this.specialAttack,
    @required this.specialDefense,
    @required this.speed,
  });

  factory RemotePokemonDetailsModel.fromJson(Map json) {
    return RemotePokemonDetailsModel(
      name: json['name'],
      id: json['id'],
      urlPhoto: json['sprites']['other']['home']['front_default'],
      types: json['types']
          .map<TypeModel>((typeJson) => TypeModel.fromJson(typeJson))
          .toList(),
      weight: json['weight'],
      height: json['height'],
      abilities: json['abilities']
          .map<AbilityModel>(
              (abilitiesJson) => AbilityModel.fromJson(abilitiesJson))
          .toList(),
      hp: json['stats'][0]['base_stat'],
      attack: json['stats'][1]['base_stat'],
      defense: json['stats'][2]['base_stat'],
      specialAttack: json['stats'][3]['base_stat'],
      specialDefense: json['stats'][4]['base_stat'],
      speed: json['stats'][5]['base_stat'],
    );
  }

  PokemonDetailsEntity toEntity() => PokemonDetailsEntity(
      name: name,
      id: id,
      urlPhoto: urlPhoto,
      types: types.map((type) => type.toEntity()).toList(),
      weight: weight,
      height: height,
      abilities: abilities.map((ability) => ability.toEntity()).toList(),
      hp: hp,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed);
}
