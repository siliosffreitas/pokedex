import 'package:flutter/material.dart';
import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

import 'components/components.dart';
import 'pokemon_details_presenter.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonDetailsPresenter presenter;

  const PokemonDetailsPage({@required this.presenter});
  @override
  Widget build(BuildContext context) {
    presenter.isLoadingStream.listen((loading) {
      if (loading == true) {
        showLoading(context);
      } else {
        hideLoading(context);
      }
    });

    presenter.loadData();

    return Scaffold(
      backgroundColor: Colors.green,
      body: Builder(
        builder: (BuildContext context) {
          return StreamBuilder<PokemonDetailsViewModel>(
              stream: presenter.pokemonDetailsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ReloadScreenPage(
                      error: snapshot.error, reload: presenter.loadData);
                }
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      CustomAppBar(
                        viewModel: snapshot.data,
                      ),
                      Expanded(child: Content(viewModel: snapshot.data)),
                    ],
                  );
                }
                return Container();
              });
        },
      ),
    );
  }
}
