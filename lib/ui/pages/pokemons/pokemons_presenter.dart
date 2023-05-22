abstract class PokemonsPresenter {
  Stream<bool> get isLoadingStream;

  Future<void> loadData();
}
