import '../entities/entities.dart';

abstract class LoadPokemons {
  Future<PokemonResultEntity> load(int page);
}
