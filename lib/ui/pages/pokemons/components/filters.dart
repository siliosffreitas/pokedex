import 'package:flutter/material.dart';
import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons_presenter.dart';

class Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PokemonsPresenter>(context);
    return Container(
      margin: EdgeInsets.only(right: 16, left: 16, bottom: 24),
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
                      _controller.selection = TextSelection.collapsed(
                          offset: _controller.text.length);
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  fontSize: 10, color: Color(0xFF666666)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            style: TextStyle(
                                fontSize: 10, color: Color(0xFF666666)),
                            onChanged: presenter.search,
                          ),
                        ),
                        if (snapshot.hasData && snapshot.data.isNotEmpty)
                          GestureDetector(
                            onTap: presenter.clearSearch,
                            child: Icon(Icons.close, size: 16),
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
                      snapshot.data == null ? 'A' : snapshot.data.symbol,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
