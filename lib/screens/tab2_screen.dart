import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatefulWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  State<Tab2Screen> createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final selectedCategory = newsService.selectedCategory;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const SizedBox(height: 100, child: _ListaCategorias()),
          if (newsService.categoryAcrticles[selectedCategory]!.isEmpty)
            const Expanded(
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 13,
                ),
              ),
            )
          else
            Expanded(
                child: ListaNoticias(
                    lista: newsService.categoryAcrticles[selectedCategory]!))
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categorias;
    final provider = Provider.of<NewsService>(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final String name = categories[index].name;
        return GestureDetector(
          onTap: () {
            provider.setSelectedCategory = categories[index].name;
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryBtn(category: categories[index]),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${name[0].toUpperCase()}${name.substring(1)}')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryBtn extends StatelessWidget {
  const _CategoryBtn({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final selectedCat = Provider.of<NewsService>(context).selectedCategory;
    return Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedCat == category.name ? Colors.red : Colors.white),
        child: Icon(
          category.icon,
          color: selectedCat == category.name ? Colors.white : Colors.black54,
        ));
  }
}
