import '../entities/entities.dart';

abstract class LoadPokemonDetails {
  Future<PokemonDetails> load(PokemonEntity pokemon);
}
