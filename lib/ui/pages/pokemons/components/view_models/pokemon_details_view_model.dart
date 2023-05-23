import 'package:meta/meta.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

class PokemonDetailsViewModel {
  final String name;
  final String id;
  final String urlPhoto;
  final List<TypeViewModel> types;
  final int weight;
  final int height;
  final List<AbilityViewModel> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

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
}
