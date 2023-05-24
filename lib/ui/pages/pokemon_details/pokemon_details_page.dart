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
      body: SafeArea(child: Builder(
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
      )),
    );
  }
}

class Content extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  Content({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4, bottom: 4),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TypesItens(viewModel: viewModel),
            TitleSession(title: 'About'),
            About(viewModel: viewModel),
            TitleSession(title: 'Base Stats'),
            Stats(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}
