import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/mixins/mixins.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/pokemon_result_view_model.dart';

class GetxPokemonsPresenter extends GetxController with LoadManager {
  final LoadPokemons loadPokemons;

  var _pokemons = Rx<PokemonsResultViewModel>();

  Stream<PokemonsResultViewModel> get pokemonsStream => _pokemons.stream;

  GetxPokemonsPresenter({@required this.loadPokemons});

  Future<void> loadData() async {
    try {
      isLoading = true;
      final pokemons = await loadPokemons.load(0);
      _pokemons.value = PokemonsResultViewModel.fromEntity(pokemons);
    } catch (error) {
      _pokemons.subject.addError(UIError.unexpected.description);
    } finally {
      isLoading = false;
    }
  }
}
