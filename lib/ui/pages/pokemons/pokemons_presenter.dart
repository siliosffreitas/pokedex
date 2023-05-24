import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';

import 'components/view_models/pokemon_result_view_model.dart';
import 'components/view_models/view_models.dart';

abstract class PokemonsPresenter {
  Stream<bool> get isLoadingStream;
  Stream<PokemonsResultViewModel> get pokemonsStream;
  Stream<Map<String, PokemonDetailsViewModel>> get pokemonDetailsStream;
  Stream<String> get navigateToStream;
  Stream<String> get searchStream;
  Stream<UISorting> get sortingStream;

  Future<void> loadData();

  void goToPokemonDetail(String id);

  Future<void> loadDetails(String pokemonName);

  void clearSearch();

  void search(String term);

  void goToChangeSorting();
}
