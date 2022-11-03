import 'package:cattle_app/core/settings/app_settings.dart';
import 'package:cattle_app/src/features/back_view/back_view_intro_page.dart';
import 'package:cattle_app/src/features/cattle_id/cattle_id_page.dart';
import 'package:cattle_app/src/features/cattle_weight/cattle_weight_page.dart';
import 'package:cattle_app/src/features/configuration/configuration_page.dart';
import 'package:cattle_app/src/features/login_mbc/login_mbc_page.dart';
import 'package:cattle_app/src/features/login_study/login_study_page.dart';
import 'package:cattle_app/src/features/menu/main_menu_page.dart';
import 'package:cattle_app/src/features/result/result_page.dart';
import 'package:cattle_app/src/features/side_view/side_view_intro_page.dart';
import 'package:cattle_app/src/features/splash/splash_page.dart';
import 'package:cattle_app/src/models/configuration_entity.dart';
import 'package:cattle_app/src/repositories/data_handler.dart';
import 'package:cattle_app/src/repositories/menu_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/constants/color_const.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/observer.dart';

class CattleApp extends StatelessWidget {
  const CattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Palette.primary,
      statusBarColor: Palette.secondary,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuHandler(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataHandler(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppSettings.title,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case AppRoute.mainMenu:
              return MaterialPageRoute(builder: (_) => const MainMenuPage());
            case AppRoute.configuration:
              final configuration = settings.arguments as ConfigurationEntity?;
              return MaterialPageRoute(
                builder: (_) => ConfigurationPage(
                  configurationEntity: configuration,
                ),
              );
            case AppRoute.result:
              return MaterialPageRoute(builder: (_) => const ResultPage());
            case AppRoute.sideViewIntro:
              return MaterialPageRoute(
                  builder: (_) => const SideViewIntroPage());
            case AppRoute.backViewIntro:
              return MaterialPageRoute(
                  builder: (_) => const BackViewIntroPage());
            case AppRoute.loginSimkeu:
              return MaterialPageRoute(
                builder: (_) => const LoginSimkeuPage(),
              );
            case AppRoute.loginMbc:
              return MaterialPageRoute(
                builder: (_) => const LoginMbcPage(),
              );
            case AppRoute.cattleWeight:
              return MaterialPageRoute(
                builder: (_) => const CattleWeightPage(),
              );
            case AppRoute.cattleId:
              return MaterialPageRoute(
                builder: (_) => const CattleIdPage(),
              );
              
          }
        },
      ),
    );
  }
}
