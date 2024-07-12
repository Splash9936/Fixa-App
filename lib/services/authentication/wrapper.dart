import 'package:fixa/fixa_main_routes.dart';

class Wrapper extends GetWidget<AuthenticationController> {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.state is UnAuthenticated) {
        return HomeLogin();
      }
      if (controller.state is Authenticated) {
        return const HomeDashBoard();
      }
      return HomeLogin();
    });
  }
}
