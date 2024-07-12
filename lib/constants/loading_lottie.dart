import 'package:fixa/fixa_main_routes.dart';

lottieLoading({required double sizeConfigHeight}) {
  return Center(
      child: Lottie.asset(Images.lottieLoadingImg,
          height: SizeConfig.heightMultiplier * sizeConfigHeight));
}
