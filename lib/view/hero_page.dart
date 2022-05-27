import 'dart:ui';

import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_morty/model/heroes.dart';
import 'package:rick_morty/service/web_service.dart';
import 'package:rick_morty/utils/debugging_util.dart';
import 'package:rick_morty/utils/filter.dart';
import 'package:rick_morty/view/hero_details_page.dart';

import '../utils/assets.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  final filterTEC = TextEditingController();
  static const _pageSize = 10;

  final PagingController<int, Hero> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addStatusListener((status) {
      if ((status == PagingStatus.ongoing ||
          status == PagingStatus.completed)) {
        setState(() {});
      }
    });

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItem = await WebService().getHeroes();
      final isLastPage = newItem.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItem);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItem, nextPageKey);
      }
    } catch (error) {
      dPrint(error, 'Hero list: ');
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hero'),
          actions: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => const Filter());
              },
              child: const Icon(Icons.more_vert),
            )
          ],
        ),
        body: FutureBuilder<List<Hero>>(
            future: WebService().getHeroes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                // dPrint(snapshot.data!.toJson(), 'Heroes');
                dPrint(snapshot.error.toString(), 'Heroes');
                return ListView.separated(
                    itemBuilder: (_, index) {
                      final item = snapshot.requireData[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => HeroItem(hero: item)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  item.image != null
                                      ? Image.network(
                                          '${item.image}',
                                          width: 64,
                                          height: 64,
                                        )
                                      : SvgPicture.asset(
                                          Assets.avatar_m,
                                          height: 64,
                                          width: 64,
                                        ),
                                  const SizedBox(width: 12),
                                  Column(
                                    children: [
                                      Text('${item.name}'),
                                      const SizedBox(height: 4),
                                      Text('${item.name}'),
                                    ],
                                  )
                                ],
                              ),
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
