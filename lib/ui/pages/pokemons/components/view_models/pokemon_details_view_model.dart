import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

String format(num n) {
  var a = n.toString().padLeft(3, '0');
  return a;
}

class PokemonDetailsViewModel extends Equatable {
  final String name;
  final String id;
  final String urlPhoto;
  final List<TypeViewModel> types;
  final String weight;
  final String height;
  final List<AbilityViewModel> abilities;
  final String hp;
  final String attack;
  final String defense;
  final String specialAttack;
  final String specialDefense;
  final String speed;

  PokemonDetailsViewModel({
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

  factory PokemonDetailsViewModel.fromEntity(PokemonDetailsEntity entity) {
    return PokemonDetailsViewModel(
      name: entity.name,
      id: '#${format(entity.id)}',
      urlPhoto: entity.urlPhoto,
      types: entity.types
          .map<TypeViewModel>((t) => TypeViewModel.fromEntity(t))
          .toList(),
      weight: '${entity.weight}',
      height: '${entity.height}',
      abilities: entity.abilities
          .map<AbilityViewModel>((t) => AbilityViewModel.fromEntity(t))
          .toList(),
      hp: '${entity.hp}',
      attack: '${entity.attack}',
      defense: '${entity.defense}',
      specialAttack: '${entity.specialAttack}',
      specialDefense: '${entity.specialDefense}',
      speed: '${entity.speed}',
    );
  }

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
