import 'package:meta/meta.dart';

class PokemonViewModel {
  final String id;
  final String url;
  final String name;

  PokemonViewModel({
    @required this.id,
    @required this.url,
    @required this.name,
  });
}
