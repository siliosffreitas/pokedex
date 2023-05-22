import 'pokemon_result_view_model.dart';

abstract class PokemonsPresenter {
  Stream<bool> get isLoadingStream;
  Stream<PokemonsResultViewModel> get pokemonsStream;

  Future<void> loadData();
}
