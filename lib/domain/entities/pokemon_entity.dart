import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PokemonEntity extends Equatable {
  final String name;
  final String url;

  PokemonEntity({
    @required this.name,
    @required this.url,
  });

  List<Object> get props => [name, url];
}
