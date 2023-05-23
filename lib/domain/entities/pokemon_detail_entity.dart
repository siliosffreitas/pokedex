import 'package:pokedex/domain/entities/entities.dart';
import 'package:meta/meta.dart';

class PokemonDetails {
  final String name;
  final int id;
  final String urlPhoto;
  final List<TypeEntity> types;
  final double weight;
  final double height;
  final List<AbilityEntity> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  PokemonDetails({
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
}
