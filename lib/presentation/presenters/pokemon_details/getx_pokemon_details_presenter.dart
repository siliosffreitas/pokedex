import 'package:get/state_manager.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/usecases/usecases.dart';

class GetxPokemonDetailsPresenter extends GetxController {
  final LoadPokemonDetails loadPokemonDetails;
  final String pokemonName;

  GetxPokemonDetailsPresenter({
    @required this.loadPokemonDetails,
    @required this.pokemonName,
  });

  Future<void> loadData() async {
    await loadPokemonDetails.loadByPokemon(pokemonName);
  }
}
