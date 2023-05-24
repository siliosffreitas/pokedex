import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_page.dart';

import 'pokemon_details_presenter_factory.dart';

Widget makePokemonDetailsPage() => PokemonDetailsPage(
      presenter:
          makeGetxPokemonDetailsPresenter(Get.parameters['pokemon_name']),
    );
