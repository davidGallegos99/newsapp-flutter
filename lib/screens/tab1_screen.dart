import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final NewsService newsService = Provider.of<NewsService>(context);
    return Scaffold(
        body: newsService.headlines.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  radius: 13,
                ),
              )
            : ListaNoticias(lista: newsService.headlines));
  }

  @override
  bool get wantKeepAlive => true;
}
