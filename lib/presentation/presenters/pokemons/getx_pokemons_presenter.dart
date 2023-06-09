import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/mixins/mixins.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class GetxPokemonsPresenter extends GetxController
    with LoadManager, NavigateManager
    implements PokemonsPresenter {
  final LoadPokemons loadPokemons;
  final LoadPokemonDetails loadPokemonDetails;

  var _foundedsPokemons = Rx<PokemonsResultViewModel>();
  PokemonsResultViewModel _allPokemons;

  var _search = RxString();
  var _details = Rx<Map<String, PokemonDetailsViewModel>>();
  var _sorting = Rx<UISorting>();

  int _page = 0;

  Stream<PokemonsResultViewModel> get pokemonsStream =>
      _foundedsPokemons.stream;
  Stream<String> get searchStream => _search.stream;
  Stream<Map<String, PokemonDetailsViewModel>> get pokemonDetailsStream =>
      _details.stream;
  Stream<UISorting> get sortingStream => _sorting.stream;

  GetxPokemonsPresenter({
    @required this.loadPokemons,
    @required this.loadPokemonDetails,
  });

  Future<void> loadData() async {
    try {
      isLoading = true;
      final pokemons = await loadPokemons.load(_page);
      final viewModel = PokemonsResultViewModel.fromEntity(pokemons);

      if (_foundedsPokemons.value == null) {
        _foundedsPokemons.value = viewModel;
        _allPokemons = viewModel;
      } else {
        final p = <PokemonViewModel>[]
          ..addAll(_foundedsPokemons.value.pokemons)
          ..addAll(viewModel.pokemons);
        final result = PokemonsResultViewModel(pokemons: p);
        _foundedsPokemons.value = result;
        _allPokemons = result;
      }
      _page++;
    } catch (error) {
      _foundedsPokemons.subject.addError(UIError.unexpected.description);
    } finally {
      isLoading = false;
    }
  }

  void goToPokemonDetail(String name) {
    navigateTo = null;
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

  void clearSearch() {
    _foundedsPokemons.value = _allPokemons;
    _search.value = null;
  }

  void search(String term) {
    _search.value = term;
    if (term?.isNotEmpty == true) {
      final p = <PokemonViewModel>[]
        ..addAll(_allPokemons.pokemons.where((pokemon) =>
            pokemon.name.toLowerCase().contains(term.toLowerCase()) ||
            _findPokemonNameByCode(term.toLowerCase()).contains(pokemon.name)));
      _foundedsPokemons.value = PokemonsResultViewModel(pokemons: p);
    } else {
      _foundedsPokemons.value = _allPokemons;
    }
  }

  List<String> _findPokemonNameByCode(String code) {
    if (_details.value != null) {
      final pokemonsWithCodeStartinWith = _details.value.values.where(
          (PokemonDetailsViewModel element) => element.id.contains(code));

      return pokemonsWithCodeStartinWith.map((e) => e.name).toList();
    }
    return [];
  }

  void goToChangeSorting() {
    navigateTo = null;
    navigateTo = '/modal_sorting';
  }

  void changeSorting(UISorting newSorting) {
    _sorting.value = newSorting;

    switch (newSorting) {
      case UISorting.number:
        _sortingByNumber();
        break;
      default:
        _sortingByName();
    }
  }

  _sortingByNumber() {
    if (_details.value != null) {
      final p = <PokemonDetailsViewModel>[]
        ..addAll(_details.value.values.toList());

      p.sort((a, b) => a.id.compareTo(b.id));

      final namesInOrderByNumber =
          p.map<String>((pokemonViewModel) => pokemonViewModel.name).toList();

      List<PokemonViewModel> pokemonsSortedByNumber = [];

      for (String name in namesInOrderByNumber) {
        final _foundeds = _foundedsPokemons.value.pokemons
            .where((pokemon) => pokemon.name == name)
            .toList();

        _foundeds.sort((a, b) => a.name.compareTo(b.name));

        pokemonsSortedByNumber.addAll(_foundeds);
      }
      _foundedsPokemons.value =
          PokemonsResultViewModel(pokemons: pokemonsSortedByNumber);
    }
  }

  _sortingByName() {
    final p = <PokemonViewModel>[]..addAll(_foundedsPokemons.value.pokemons);
    p.sort((a, b) => a.name.compareTo(b.name));

    _foundedsPokemons.value = PokemonsResultViewModel(pokemons: p);
  }
}
