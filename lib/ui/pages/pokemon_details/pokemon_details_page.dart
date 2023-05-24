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

class CustomAppBar extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  CustomAppBar({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              height: 200,
              child: Stack(
                children: [
                  AppBar(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    title: Text(
                      viewModel.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Text(
                          viewModel.id,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Image(
                      image: AssetImage('lib/ui/assets/Pokeball.png'),
                      height: 200,
                      width: 200,
                      fit: BoxFit.fitWidth,
                      color: Colors.white.withAlpha(50),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 4, right: 4),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: Colors.white,
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 70),
          child: Image.network(
            viewModel.urlPhoto,
            width: 200,
          ),
        ),
      ],
    );
  }
}
