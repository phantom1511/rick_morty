import 'package:flutter/material.dart' hide Hero;
import 'package:rick_morty/model/episode.dart';
import 'package:rick_morty/service/web_service.dart';
import 'package:rick_morty/utils/debugging_util.dart';

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
        body: FutureBuilder<Episode>(
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
                      final item = snapshot.data!.results[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(item.name),
                              Text(item.characters.first),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 8),
                    itemCount: snapshot.data?.results.length ?? 0);
              }
              return snapshot.hasError != true
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : const Center(
                      child: Text('Something went wrong'),
                    );
            }));
  }
}
