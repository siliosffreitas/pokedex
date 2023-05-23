import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

class PokemonResultEntity extends Equatable {
  final int total;
  final List<PokemonEntity> pokemons;

  PokemonResultEntity({@required this.total, @required this.pokemons});

  List<Object> get props => [total, pokemons];
}
