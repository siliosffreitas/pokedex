import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/ui/helpers/utils.dart';

class PokemonViewModel extends Equatable {
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
      name: capitalize(entity.name),
      url: entity.url,
    );
  }

  List<Object> get props => [id, url, name];
}
