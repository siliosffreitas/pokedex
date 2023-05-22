import '../entities/entities.dart';

abstract class LoadPokemons {
  Future<List<PokemonResult>> load(int page);
}
