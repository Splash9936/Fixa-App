// ignore_for_file: prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class HomeWorkForce extends GetWidget<HomeWorkForceController> {
  const HomeWorkForce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // check for projects
    // if one project
    // if many project
    // if no project
    return Obx(() {
      if (controller.projects.length == 1) {
        return WorforceBody(
            project: controller.projects[0], statusNavigator: true);
      } else if (controller.projects.length > 1) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 20,
                ),
                Text(
                  "Select Project",
                  style: TextStyling.bigBlackBoldText,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.projects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => Get.toNamed(
                                    RouteLinks.homeWorkForceData,
                                    arguments: {
                                      "project": controller.projects[index],
                                      "status": false,
                                    }),
                            child: _cardProject(
                                project: controller.projects[index],
                                contractor: checkForStringNull(
                                    controller.projects[index].companyName,
                                    "")));
                      }),
                )
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: whiteColor,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 20,
                ),
                Text(
                  "Select Projects",
                  style: TextStyling.bigBlackBoldText,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.projects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => Get.toNamed(
                                    RouteLinks.homeWorkForceData,
                                    arguments: {
                                      "project": controller.projects[index],
                                      "status": false
                                    }),
                            child: _cardProject(
                                project: controller.projects[index],
                                contractor: checkForStringNull(
                                    controller.projects[index].companyName,
                                    "")));
                      }),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  _cardProject({required Project project, required String contractor}) {
    return Card(
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
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              project.projectProfileUrl == null ||
                      project.projectProfileUrl!.isEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 1.5),
                      decoration: BoxDecoration(
                          color: textFormColor, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          nameProfileText(project.projectName),
                          style: TextStyling.formBlueTextStyle,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: SizeConfig.widthMultiplier * 8,
                      backgroundImage: NetworkImage(project.projectProfileUrl!),
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
              //     Text(
              //      fullNameCapitalised(project.projectName!),
              //       style: TextStyling.bigBlackBoldText,
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
    );
  }
}
