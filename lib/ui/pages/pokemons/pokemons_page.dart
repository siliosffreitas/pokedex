import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import 'components/view_models/view_models.dart';
import 'pokemons_presenter.dart';

class PokemonsPage extends StatelessWidget {
  final PokemonsPresenter presenter;

  const PokemonsPage({@required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('lib/ui/assets/Pokeball.png'),
          ),
        ),
        bottom: PreferredSize(
            child: Provider(
              create: (_) => presenter,
              child: Filters(),
            ),
            preferredSize: Size(100, 56)),
      ),
      backgroundColor: Color(0xFFDC0A2D),
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((loading) {
            if (loading == true) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter.loadData();
          presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              if (page == '/modal_sorting') {
                showSortingModal(context, presenter);
              } else {
                Get.toNamed(page);
              }
            }
          });
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: StreamBuilder<PokemonsResultViewModel>(
                      stream: presenter.pokemonsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return ReloadScreenPage(
                              error: snapshot.error,
                              reload: presenter.loadData);
                        }
                        if (snapshot.hasData) {
                          return Provider(
                            create: (_) => presenter,
                            child: PokemonItens(viewModel: snapshot.data),
                          );
                        }
                        return Container();
                      }),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
