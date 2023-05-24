import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/mixins/mixins.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class GetxPokemonsPresenter extends GetxController
    with LoadManager, NavigateManager
    implements PokemonsPresenter {
  final LoadPokemons loadPokemons;
  final LoadPokemonDetails loadPokemonDetails;

  var _pokemons = Rx<PokemonsResultViewModel>();

  var _details = Rx<Map<String, PokemonDetailsViewModel>>();

  int _page = 0;

  Stream<PokemonsResultViewModel> get pokemonsStream => _pokemons.stream;
  Stream<String> get searchStream => throw UnimplementedError();

  Stream<Map<String, PokemonDetailsViewModel>> get pokemonDetailsStream =>
      _details.stream;

  GetxPokemonsPresenter({
    @required this.loadPokemons,
    @required this.loadPokemonDetails,
  });

  Future<void> loadData() async {
    try {
      isLoading = true;
      final pokemons = await loadPokemons.load(_page);
      final viewModel = PokemonsResultViewModel.fromEntity(pokemons);

      if (_pokemons.value == null) {
        _pokemons.value = viewModel;
      } else {
        final p = <PokemonViewModel>[]
          ..addAll(_pokemons.value.pokemons)
          ..addAll(viewModel.pokemons);
        _pokemons.value = PokemonsResultViewModel(pokemons: p);
      }
      _page++;
    } catch (error) {
      _pokemons.subject.addError(UIError.unexpected.description);
    } finally {
      isLoading = false;
    }
  }

  void goToPokemonDetail(String name) {
    navigateTo = '/pokemon/$name';
  }

  Future<void> loadDetails(String pokemonName) async {
    try {
      final details =
          await loadPokemonDetails.loadByPokemon(pokemonName.toLowerCase());
      final viewModel = PokemonDetailsViewModel.fromEntity(details);
      if (_details.value == null || _details.value.isEmpty) {
        final map = {pokemonName: viewModel};
        _details.value = map;
      } else {
        final map = {pokemonName: viewModel}
          ..addEntries(_details.value.entries);
        _details.value = map;
      }
    } catch (error) {
      _details.subject.addError(UIError.unexpected.description);
    }
  }
}
