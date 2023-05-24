import 'package:flutter/material.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';
import 'package:provider/provider.dart';

void showSortingModal(BuildContext context, PokemonsPresenter presenter) {
  showDialog(
      context: context,
      child: SimpleDialog(
        children: [
          Container(
            color: Colors.red,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sort by:'),
                Container(
                  color: Colors.white,
                  child: Provider(
                    create: (_) => presenter,
                    child: Column(
                      children: UISorting.values
                          .map((entry) => SortingItem(sorting: entry))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ));
}

class SortingItem extends StatelessWidget {
  final UISorting sorting;

  const SortingItem({@required this.sorting});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PokemonsPresenter>(context);

    return StreamBuilder<UISorting>(
        stream: presenter.sortingStream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              presenter.changeSorting(sorting);
            },
            child: Row(
              children: [
                Icon(snapshot.hasData && snapshot.data == sorting
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked),
                Text(sorting.description)
              ],
            ),
          );
        });
  }
}
