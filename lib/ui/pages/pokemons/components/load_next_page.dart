import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pokemons.dart';

class LoadNextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PokemonsPresenter>(context);
    return Builder(builder: (context) {
      presenter.loadData();
      return Container();
    });
  }
}
