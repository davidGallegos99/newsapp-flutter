import 'package:flutter/material.dart';
import 'package:news_app/screens/tab1_screen.dart';
import 'package:news_app/screens/tab2_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _NavigationModel(),
        child: const Scaffold(
            bottomNavigationBar: SizedBox(height: 70, child: _NavBar()),
            body: _Paginas()));
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _NavigationModel provider = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
        onTap: (int i) => provider.setPaginaActual = i,
        currentIndex: provider.paginaActual,
        items: const [
          BottomNavigationBarItem(
            label: 'Para ti',
            icon: Icon(Icons.person_outline),
          ),
          BottomNavigationBarItem(
            label: 'Encabezados',
            icon: Icon(Icons.public),
          )
        ]);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _NavigationModel provider = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: provider.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [Tab1Screen(), Tab2Screen()],
    );
  }
}

class _NavigationModel extends ChangeNotifier {
  int _paginaActual = 0;
  final PageController _controller = PageController();

  PageController get pageController => _controller;
  int get paginaActual => _paginaActual;

  set setPaginaActual(int val) {
    _paginaActual = val;
    _controller.animateToPage(val,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }
}

// da323390053846e9b7a4da0dd6a97947