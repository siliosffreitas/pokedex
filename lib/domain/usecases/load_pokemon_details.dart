import '../entities/entities.dart';

abstract class LoadPokemonDetails {
  Future<PokemonDetailsEntity> load(PokemonEntity pokemon);
}
