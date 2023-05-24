import 'package:pokedex/main/factories/usecases/load_pokemon_details_factory.dart';
import 'package:pokedex/presentation/presenters/pokemon_details/getx_pokemon_details_presenter.dart';
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_presenter.dart';

PokemonDetailsPresenter makeGetxPokemonDetailsPresenter(String pokemonName) {
  return GetxPokemonDetailsPresenter(
    loadPokemonDetails: makeRemoteLoadPokemonDetails(),
    pokemonName: pokemonName,
  );
}
