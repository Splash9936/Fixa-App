import 'package:fixa/fixa_main_routes.dart';

class DefaultButton extends StatelessWidget {
  final String? text;
  final GestureTapCallback? press;
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.heightMultiplier * 7.4,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(blueColorText)),
          onPressed: press,
          child: Text(
            text!,
            style: TextStyling.buttonWhiteTextStyle,
          ),
        ),
      ),
    );
  }
}

class DefaultButtonEmpty extends StatelessWidget {
  final String? text;
  final GestureTapCallback? press;
  const DefaultButtonEmpty({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: SizeConfig.heightMultiplier * 7.4,
        decoration: BoxDecoration(
          color: lightgreyBlueGreyColor,
          border: Border.all(color: greyBlackColorText),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Text(
          text!,
          style: TextStyling.buttonGreyedTextStyle,
        )),
      ),
    );
  }
}
