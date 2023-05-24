abstract class PokemonDetailsPresenter {
  Stream<bool> get isLoadingStream;
  Future<void> loadData();
}
