import 'package:get/state_manager.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/mixins/mixins.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_presenter.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/pokemon_details_view_model.dart';

class GetxPokemonDetailsPresenter extends GetxController
    with LoadManager
    implements PokemonDetailsPresenter {
  final LoadPokemonDetails loadPokemonDetails;
  final String pokemonName;

  var _details = Rx<PokemonDetailsViewModel>();

  Stream<PokemonDetailsViewModel> get pokemonDetailsStream => _details.stream;

  GetxPokemonDetailsPresenter({
    @required this.loadPokemonDetails,
    @required this.pokemonName,
  });

  Future<void> loadData() async {
    try {
      isLoading = true;
      final details =
          await loadPokemonDetails.loadByPokemon(pokemonName.toLowerCase());
      final viewModel = PokemonDetailsViewModel.fromEntity(details);
      _details.value = viewModel;
    } catch (error) {
      _details.subject.addError(UIError.unexpected.description);
    } finally {
      isLoading = false;
    }
  }
}
