// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'fixa_main_routes.dart';

// // ******** for handling certfcates issues ***************
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

iOSPlatformExceptionHandler() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('first_run') ?? true) {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.deleteAll();

    prefs.setBool('first_run', false);
  }
}

// get app fvlavor values
appFlavors() async{
AppValues appValues = await DataProvider().getAppFlavorDetails();
if(appValues.appTitle == null || appValues.appTitle!.isEmpty ){
  AppConfig(appValues: appValuesEnv[0]);
}else {
  AppConfig(appValues: appValues);
}

}

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  await iOSPlatformExceptionHandler();
  await appFlavors();
  initialize();
  runApp(MyApp());
}

void initialize() {
  Get.lazyPut(
    () => MainController(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (builder, orientation) {
        SizeConfig().init(constraints, orientation);
        return GetMaterialApp(
          initialRoute: RouteLinks.wrapper,
          getPages: AppRouter.pages,
          // initialBinding: AuthBinding(),
          title: 'Fixa',
          debugShowCheckedModeBanner: false,
          theme: theme(),
        );
      });
    });
  }
}


void performHotRestart() {
  main();
}
