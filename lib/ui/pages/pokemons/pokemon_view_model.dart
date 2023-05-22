import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

class PokemonViewModel {
  final String id;
  final String url;
  final String name;

  PokemonViewModel({
    @required this.id,
    @required this.url,
    @required this.name,
  });

  factory PokemonViewModel.fromEntity(PokemonEntity entity) {
    return PokemonViewModel(
      id: null,
      name: entity.name,
      url: entity.url,
    );
  }
}
