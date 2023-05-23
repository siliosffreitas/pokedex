import 'package:equatable/equatable.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:meta/meta.dart';

class PokemonDetailsEntity extends Equatable {
  final String name;
  final int id;
  final String urlPhoto;
  final List<TypeEntity> types;
  final int weight;
  final int height;
  final List<AbilityEntity> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  PokemonDetailsEntity({
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

  List<Object> get props => [
        name,
        id,
        urlPhoto,
        types,
        weight,
        height,
        abilities,
        hp,
        attack,
        defense,
        specialAttack,
        specialDefense,
        speed
      ];
}
