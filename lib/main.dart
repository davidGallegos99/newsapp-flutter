import 'package:flutter/material.dart';
import 'package:news_app/screens/tabs_screen.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsService())],
      child: MaterialApp(
          theme: Apptheme.theme,
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: const TabsScreen()),
    );
  }
}
