import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_svg/svg.dart';
import 'package:rick_morty/service/web_service.dart';
import 'package:rick_morty/utils/debugging_util.dart';
import 'package:rick_morty/utils/details_card.dart';

import '../model/heroes.dart';
import '../utils/assets.dart';

class HeroItem extends StatelessWidget {
  const HeroItem({Key? key, required this.hero}) : super(key: key);
  final Hero hero;

  @override
  Widget build(BuildContext context) {
    dPrint(hero.toJson(), 'Hero in details: ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero detail'),
      ),
      body: DetailsCard(
          image: hero.image,
          gender: hero.gender,
          location: hero.location?.name,
          name: hero.name,
          status: hero.status,
          type: hero.status),
    );
  }
}
