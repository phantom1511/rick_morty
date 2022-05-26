import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_svg/svg.dart';
import 'package:rick_morty/service/web_service.dart';

import '../model/heroes.dart';
import '../utils/assets.dart';

class HeroDetailsPage extends StatefulWidget {
  const HeroDetailsPage({Key? key}) : super(key: key);

  @override
  _HeroDetailsPageState createState() => _HeroDetailsPageState();
}

class _HeroDetailsPageState extends State<HeroDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<Hero>>(
              future: WebService().getHeroes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const Center(child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  ListView.builder(
                      itemBuilder: (_, index) =>
                          CharacterItem(hero: snapshot.data![index]));
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }),
        ));
  }
}

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.hero}) : super(key: key);
  final Hero hero;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            Text('${hero.location}'),
            const SizedBox(height: 8),
            Text('${hero.gender}'),
          ],
        ),
      ),
    );
    ;
  }
}
