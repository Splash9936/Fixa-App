import 'package:fixa/fixa_main_routes.dart';

class HomeDashBoard extends StatelessWidget {
  const HomeDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainController>(
          init: MainController(),
          builder: (controller) {
            // return PageView(
            //     children: controller.widgets,
            //     controller: controller.pageController.value,
            //     onPageChanged: (page) => {controller.changeIndex(index: page)});
            return IndexedStack(
              index: controller.selectedIndex,
              children: controller.widgets,
            );
          }),
      bottomNavigationBar: GetBuilder<MainController>(builder: (controller) {
        return BottomNavigationBar(
            backgroundColor: whiteColor,
            selectedItemColor: blackColorText,
            unselectedItemColor: greyBlackColorText,
            selectedLabelStyle: TextStyling.buttonMediumTextStyle,
            unselectedLabelStyle: TextStyling.greyTextStyle,
            currentIndex: controller.selectedIndex,
            onTap: (index) => controller.changeIndex(index: index),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.homePageIcon,
                  color: controller.selectedIndex == 0
                      ? blackColorText
                      : greyBlackColorText,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.homeAttendanceIcon,
                  color: controller.selectedIndex == 1
                      ? blackColorText
                      : greyBlackColorText,
                ),
                label: 'Attendance',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.homeWorkForceIcon,
                  color: controller.selectedIndex == 2
                      ? blackColorText
                      : greyBlackColorText,
                ),
                label: 'Workforce',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.homePayrollIcon,
                  color: controller.selectedIndex == 3
                      ? blackColorText
                      : greyBlackColorText,
                ),
                label: 'Payroll',
              ),
            ]);
      }),
    );
  }
}
