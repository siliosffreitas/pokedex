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
                showSortingModal(context);
              } else {
                Get.toNamed(page);
              }
            }
          });
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 108,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 32,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage('lib/ui/assets/Pokeball.png'),
                                height: 24,
                                width: 24),
                            SizedBox(width: 16),
                            Image(
                                image: AssetImage('lib/ui/assets/Pokedex.png'),
                                height: 22),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 32,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: StreamBuilder<String>(
                                    stream: presenter.searchStream,
                                    builder: (context, snapshot) {
                                      final TextEditingController _controller =
                                          TextEditingController();

                                      if (snapshot.data != null) {
                                        _controller.text = snapshot.data;
                                        _controller.selection =
                                            TextSelection.collapsed(
                                                offset:
                                                    _controller.text.length);
                                      }

                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.search, size: 16),
                                          SizedBox(height: 8),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Search',
                                                hintStyle: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xFF666666)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                              ),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF666666)),
                                              onChanged: presenter.search,
                                            ),
                                          ),
                                          if (snapshot.hasData &&
                                              snapshot.data.isNotEmpty)
                                            GestureDetector(
                                              onTap: presenter.clearSearch,
                                              child:
                                                  Icon(Icons.close, size: 16),
                                            ),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(width: 16),
                            GestureDetector(
                              onTap: presenter.goToChangeSorting,
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: StreamBuilder<UISorting>(
                                    stream: presenter.sortingStream,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data == null
                                            ? 'A'
                                            : snapshot.data.symbol,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
            ),
          );
        },
      ),
    );
  }
}
