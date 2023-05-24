import 'package:flutter/material.dart';
import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';
import 'package:provider/provider.dart';

void showSortingModal(BuildContext context, PokemonsPresenter presenter) {
  showDialog(
      context: context,
      child: SimpleDialog(
        backgroundColor: Color(0xFFDC0A2D),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text('Sort by:',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.white)),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
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

void hideSortingModal(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
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
              hideSortingModal(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    snapshot.hasData && snapshot.data == sorting
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 14,
                  ),
                  SizedBox(width: 10),
                  Text(
                    sorting.description,
                    style: TextStyle(
                      color: Color(0xFF1D1D1D),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
