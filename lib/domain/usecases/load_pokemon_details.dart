import '../entities/entities.dart';

abstract class LoadPokemonDetails {
  Future<PokemonDetailsEntity> loadByPokemon(String pokemonName);
}
