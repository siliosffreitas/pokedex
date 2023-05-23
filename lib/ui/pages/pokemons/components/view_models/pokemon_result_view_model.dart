import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

import 'pokemon_view_model.dart';

class PokemonsResultViewModel extends Equatable {
  final List<PokemonViewModel> pokemons;

  PokemonsResultViewModel({
    @required this.pokemons,
  });

  factory PokemonsResultViewModel.fromEntity(PokemonResultEntity entity) {
    return PokemonsResultViewModel(
        pokemons: entity.pokemons
            .map((pokemonEntity) => PokemonViewModel.fromEntity(pokemonEntity))
            .toList());
  }

  List<Object> get props => [pokemons];
}
