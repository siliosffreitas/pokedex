import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/usecases/usecases.dart';

class GetxPokemonsPresenter extends GetxController {
  final LoadPokemons loadPokemons;

  GetxPokemonsPresenter({@required this.loadPokemons});
  Future<void> loadData() async {
    await loadPokemons.load(0);
  }
}
