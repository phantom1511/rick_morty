import 'dart:ui';

import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_morty/model/episode.dart';
import 'package:rick_morty/model/heroes.dart';
import 'package:rick_morty/service/web_service.dart';
import 'package:rick_morty/utils/debugging_util.dart';
import 'package:rick_morty/utils/filter.dart';
import 'package:rick_morty/view/hero_details_page.dart';

import '../utils/assets.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({Key? key}) : super(key: key);

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Episode'),
        ),
        body: FutureBuilder<List<Episode>>(
            future: WebService().getEpisode(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                dPrint(snapshot.data.toString(), 'Episode');
                dPrint(snapshot.error.toString(), 'Episode');
                return ListView.separated(
                    itemBuilder: (_, index) {
                      final item = snapshot.requireData[index].results[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                item.name,
                                width: 64,
                                height: 64,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 8),
                    itemCount: snapshot.data?.length ?? 0);
              }
              return snapshot.hasError != true
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : const Center(
                      child: Text('Something went wrong'),
                    );
            }));
  }
}
