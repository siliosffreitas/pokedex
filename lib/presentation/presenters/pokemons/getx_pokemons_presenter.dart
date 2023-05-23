import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/mixins/mixins.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/pokemon_result_view_model.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class GetxPokemonsPresenter extends GetxController
    with LoadManager, NavigateManager
    implements PokemonsPresenter {
  final LoadPokemons loadPokemons;

  var _pokemons = Rx<PokemonsResultViewModel>();

  int _page = 0;

  Stream<PokemonsResultViewModel> get pokemonsStream => _pokemons.stream;

  GetxPokemonsPresenter({@required this.loadPokemons});

  Future<void> loadData() async {
    try {
      isLoading = true;
      final pokemons = await loadPokemons.load(_page);
      _pokemons.value = PokemonsResultViewModel.fromEntity(pokemons);
      _page++;
    } catch (error) {
      _pokemons.subject.addError(UIError.unexpected.description);
    } finally {
      isLoading = false;
    }
  }

  void goToPokemonDetail(String id) {
    navigateTo = '/pokemon/$id';
  }
}
