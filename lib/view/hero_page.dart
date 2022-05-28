import 'package:flutter/material.dart' hide Hero;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_morty/model/heroes.dart';
import 'package:rick_morty/service/web_service.dart';
import 'package:rick_morty/utils/debugging_util.dart';
import 'package:rick_morty/utils/filter.dart';
import 'package:rick_morty/utils/hero_card.dart';
import 'package:rick_morty/view/hero_details_page.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  final filterTEC = TextEditingController();
  static const _pageSize = 20;

  final _pagingController = PagingController<int, Hero>(firstPageKey: 1);

  String? gender;

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
    debugPrint('_fetchPage $pageKey');
    try {
      final newItem = await WebService().getHeroes(
        page: pageKey,
        count: _pageSize,
        gender: gender,
      );
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
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: const Text('Hero'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () async {
                final result = await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => const Filter());

                if (result != null) {
                  gender = result;
                  _pagingController.refresh();
                }
              },
              child: const Icon(Icons.more_vert),
            )
          ],
        ),
        body: PagedListView<int, Hero>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Hero>(
            firstPageProgressIndicatorBuilder: (_) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            noMoreItemsIndicatorBuilder: (_) =>
                const Center(child: Text('Nothing found')),
            newPageErrorIndicatorBuilder: (_) =>
                const Center(child: Text('Something went wrong')),
            itemBuilder: (context, item, index) => HeroCard(
              imageUrl: item.image,
              name: item.name,
              gender: item.gender,
              onPressDetails: () async {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => HeroItem(hero: item)));
              },
            ),
          ),
        ));
  }
}
