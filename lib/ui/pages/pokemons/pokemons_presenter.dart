import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

import 'pokemon_result_view_model.dart';

abstract class PokemonsPresenter {
  Stream<bool> get isLoadingStream;
  Stream<PokemonsResultViewModel> get pokemonsStream;
  Stream<String> get navigateToStream;

  Future<void> loadData();

  void goToPokemonDetail(String id);

  void loadDetails(PokemonViewModel pokemon);
}
