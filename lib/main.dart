import 'package:flutter/material.dart';
import 'package:simple_flutter_app/data/providers/theme_providers.dart';
import 'package:simple_flutter_app/presentation/pages/auth_pages/login_page.dart';
import 'data/routes/route.dart' as route;
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ThemeProviders())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: context.watch<ThemeProviders>().isDarkmodeEnabled
            ? Brightness.dark
            : Brightness.light,
      ),
      onGenerateRoute: route.Routes.controller,
      initialRoute: route.Routes.get_started,
      // theme: ThemeData.dark(),
    );
  }
}
