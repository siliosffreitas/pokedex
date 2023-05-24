import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

abstract class PokemonDetailsPresenter {
  Stream<bool> get isLoadingStream;
  Stream<PokemonDetailsViewModel> get pokemonDetailsStream;

  Future<void> loadData();
}
