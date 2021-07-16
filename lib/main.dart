import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/screen/logint_screen.dart';
import 'package:inventory_app/views/screen/product_screen.dart';
import 'package:inventory_app/views/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/veiwmodels/auth_viewmodel.dart';

void main() {
  runApp(GetMaterialApp(
    home: MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
    ], child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:StatUpLogic(),
    );
  }
}


class StatUpLogic extends StatelessWidget {
  const StatUpLogic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (_, prefs) {
        if (prefs.hasData) {
          if (prefs.data.getString(kShareLoginFyear) != null) {
            return ProductScreen();
          } else {
            return LoginScreen();
          }
        }
        return Material(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
