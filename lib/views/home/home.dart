// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:fixa/fixa_main_routes.dart';

class HomePage extends GetWidget<MainController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreyBlueGreyColor,
      body: SafeArea(
          child: Obx(
        () => controller.isNotification.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  _userProfile(),
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  // _notificationListContainer(context: context)
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  _userProfile(),
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 8),
                    child: Text(
                      "Projects",
                      style: TextStyling.bigBlackBoldText,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  _projectCard(),
                  SizedBox(height: SizeConfig.heightMultiplier * 3),
                  // controller.attendanceStatuses.isEmpty
                  //     ? Container()
                  //     : _notificationContainer(context: context),
                ],
              ),
      )),
    );
  }

  _projectCard() {
    return Expanded(
        flex: 1,
        child: Obx(
          () => controller.isDashboardLoading.value
              ? lottieLoading(sizeConfigHeight: 16)
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.projects.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => controller.indexToAttendance(
                            projectChoosen: controller.projects[index]),
                        child: _cardProject(
                            project: controller.projects[index],
                            contractor: checkForStringNull(
                                controller.projects[index].companyName, "")));
                  }),
        ));
  }

  _cardProject({required Project project, required String contractor}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 5,
          vertical: SizeConfig.heightMultiplier * 1.5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2,
        child: Container(
          height: SizeConfig.heightMultiplier * 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                project.projectProfileUrl == null ||
                        project.projectProfileUrl!.isEmpty
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 1.5),
                        // width: SizeConfig.widthMultiplier * 12,
                        decoration: BoxDecoration(
                            color: textFormColor, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            nameProfileText(project.projectName),
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyling.formBlueTextStyle,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: SizeConfig.widthMultiplier * 8,
                        backgroundImage:
                            NetworkImage(project.projectProfileUrl!),
                      ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 3,
                ),
                Expanded(
                    child: Text(
                  fullNameCapitalised(project.projectName!),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyling.bigBlackBoldText,
                ))
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       width: SizeConfig.widthMultiplier * 54,
                //       child: Text(
                //         fullNameCapitalised(project.projectName!),
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyling.bigBlackBoldText,
                //       ),
                //     ),
                //     // SizedBox(height: SizeConfig.heightMultiplier * 0.7),
                //     // Text(
                //     //   contractor,
                //     //   style: TextStyling.blueTextStyle,
                //     // ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _userProfile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Images.logoFixaIcon,
            height: SizeConfig.heightMultiplier * 8,
            // width: SizeConfig.widthMultiplier * 30,
          ),
          GestureDetector(
            onTap: () => Get.toNamed(RouteLinks.homeUserProfile),
            child: Container(
              height: SizeConfig.heightMultiplier * 8,
              width: 50,
              decoration:
                  BoxDecoration(color: blueDark, shape: BoxShape.circle),
              child: Center(
                child: SvgPicture.asset(
                  Images.userLogo,
                  color: whiteColor,
                  height: SizeConfig.heightMultiplier * 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
