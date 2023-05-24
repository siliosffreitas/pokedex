import 'package:flutter/material.dart';
import 'package:pokedex/main/factories/pages/pokemons/pokemons_presenter_factory.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons_page.dart';

Widget makePokemonsPage() =>
    PokemonsPage(presenter: makeGetxPokemonsPresenter());
