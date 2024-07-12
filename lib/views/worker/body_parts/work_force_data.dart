// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_string_interpolations, prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';
import 'package:fixa/views/worker/add_worker_page.dart';

class WorforceBody extends GetWidget<HomeWorkForceController> {
  final Project project;
  final bool statusNavigator;
  WorforceBody({Key? key, required this.project, required this.statusNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreyBlueGreyColor,
      body: GetBuilder<HomeWorkForceController>(
          initState: (_) =>
              controller.getWorkersFromProjects(projectId: project.projectId!),
          builder: (cons) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 6),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteLinks.homeSearchWorker,
                            arguments: {
                              "project": project,
                              "assigned_workers":
                                  controller.mainController.allAssignedWorkers
                            }),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 2,
                          child: Container(
                            height: SizeConfig.heightMultiplier * 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 3),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Search by name,phone or ID",
                                      style: TextStyling.formGreyTextStyle),
                                  SvgPicture.asset(
                                    Images.searchIcon,
                                    height: SizeConfig.heightMultiplier * 2,
                                    color: appBarColorText,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(() => controller.mainController.allAssignedWorkers.isEmpty 
                        ? Container() 
                        : _infoBodyCards(workerServicesCount: getWorkersPerServices(
                            assignedWorkers: controller.mainController.allAssignedWorkers,
                            services: project.services!, 
                            projectId: project.projectId!
                          )),
                      ),
                    ],
                  ),
                  Positioned(
                      top: SizeConfig.heightMultiplier * 10,
                      left: SizeConfig.widthMultiplier * 4,
                      child: GestureDetector(
                        onTap: () {
                          if (!statusNavigator) {
                            Get.back();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 2.5),
                          height: SizeConfig.heightMultiplier * 6,
                          width: SizeConfig.widthMultiplier * 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightgreyBlueGreyColor,
                          ),
                          child: SvgPicture.asset(
                            Images.leftArrowIcon,
                            color: statusNavigator
                                ? lightgreyBlueGreyColor
                                : appBarColorText,
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: SizeConfig.heightMultiplier * 2,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => AddWorkerPage());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.heightMultiplier * 1.5),
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 6),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Add Worker",
                            style: TextStyling.buttonTextStyle.copyWith(
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  _infoBodyCards({required List<Map<String, String>> workerServicesCount}) {
    return Obx(() => controller.mainController.isWorkForceLoading.value
        ? lottieLoading(sizeConfigHeight: 16)
        : SizedBox(
            height: SizeConfig.heightMultiplier * 45,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.6,
                ),
                itemCount: workerServicesCount.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.toNamed(RouteLinks.homeSearchWorker, arguments: {
                      "project": project,
                      "assigned_workers": getAssignedWorkerNumber(
                          assignedWorkers:
                              controller.mainController.allAssignedWorkers,
                          serviceId: int.parse(workerServicesCount[index]['service_id']!))
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                          color: lightgreyBlueGreyColor,
                          border: Border.all(color: textFormBorderColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${workerServicesCount[index]['count']}",
                            style: TextStyling.blueTextStyle,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1.2,
                          ),
                          Text(
                            "${workerServicesCount[index]['serviceName']}",
                            style: TextStyling.buttonGreyedTextStyle,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ));
  }
}
