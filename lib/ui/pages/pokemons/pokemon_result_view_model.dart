import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

import 'pokemon_view_model.dart';

class PokemonsResultViewModel {
  final List<PokemonViewModel> pokemons;

  PokemonsResultViewModel({
    @required this.pokemons,
  });

  factory PokemonsResultViewModel.fromEntity(PokemonResultEntity entity) {
    return PokemonsResultViewModel(
        pokemons: entity.pokemons
            .map<PokemonViewModel>((p) => PokemonViewModel.fromEntity(p))
            .toList());
  }
}
