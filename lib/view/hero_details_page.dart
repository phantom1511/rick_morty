import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_svg/svg.dart';
import 'package:rick_morty/service/web_service.dart';
import 'package:rick_morty/utils/debugging_util.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              hero.image != null
                  ? Image.network(
                      '${hero.image}',
                      width: 150,
                      height: 150,
                    )
                  : SvgPicture.asset(
                      Assets.avatar_m,
                      width: 150,
                      height: 150,
                    ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Text('${hero.name}'),
              const SizedBox(height: 8),
              Text('${hero.status}'),
              const SizedBox(height: 8),
              Text('${hero.type}'),
              const SizedBox(height: 8),
              Text('${hero.location?.name}'),
              const SizedBox(height: 8),
              Text('${hero.gender}'),
            ],
          ),
        ),
      ),
    );
  }
}
