import 'package:pokedex/main/factories/usecases/load_pokemon_details_factory.dart';
import 'package:pokedex/main/factories/usecases/load_pokemons_factory.dart';
import 'package:pokedex/presentation/presenters/pokemons/getx_pokemons_presenter.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

PokemonsPresenter makeGetxSurveysPresenter() {
  return GetxPokemonsPresenter(
    loadPokemons: makeRemoteLoadPokemons(),
    loadPokemonDetails: makeRemoteLoadPokemonDetails(),
  );
}
