import 'package:fixa/fixa_main_routes.dart';

appBar({required String text}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () => Get.back(),
        child: SvgPicture.asset(
          Images.leftArrowIcon,
          color: blackColor,
          width: SizeConfig.widthMultiplier * 6,
        ),
      ),
      SizedBox(width: SizeConfig.widthMultiplier * 25),
      Text(text, style: TextStyling.nameProfileTextStyle)
    ],
  );
}
