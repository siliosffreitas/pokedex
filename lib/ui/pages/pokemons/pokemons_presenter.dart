import 'components/view_models/pokemon_result_view_model.dart';
import 'components/view_models/view_models.dart';

abstract class PokemonsPresenter {
  Stream<bool> get isLoadingStream;
  Stream<PokemonsResultViewModel> get pokemonsStream;
  Stream<Map<String, PokemonDetailsViewModel>> get pokemonDetailsStream;
  Stream<String> get navigateToStream;

  Future<void> loadData();

  void goToPokemonDetail(String id);

  void loadDetails(PokemonViewModel pokemon);
}
