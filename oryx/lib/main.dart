import 'dart:async';
import 'oryx_app.dart';
import 'injector.dart';
import 'core/blocs/bloc_observer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'core/other/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'core/other/config_easy_loader.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      /// Initialize service locator
      await setupLocators();

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      );

      /// Set theme for EasyLoader indicator
      ConfigEasyLoader.darkTheme();

      /// Setup global observer to monitor all blocs
      Bloc.observer = OryxBlocObserver();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory(),
      );

      runApp(
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: const OryxAppWrapper(),
        ),
      );
    },
    (error, stack) {
      debugPrint("runZonedGuarded: Caught error in my root zone. $error | stack $stack");
    },
  );
}
