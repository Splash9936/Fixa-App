// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:fixa/fixa_main_routes.dart';

class HomeSearchWorker extends GetWidget<HomeSearchWorkerController> {
  final Project project;
  final List<AssignedWorkers> assignedWorkers;
  HomeSearchWorker(
      {Key? key, required this.project, required this.assignedWorkers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreyBlueGreyColor,
      body: GetBuilder<HomeSearchWorkerController>(
          init: HomeSearchWorkerController(),
          initState: (_) => controller.setWorkers(workers: assignedWorkers),
          builder: (cons) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 3),
                  _appBar(context: context),
                  SizedBox(height: SizeConfig.heightMultiplier * 3),
                  _selectedWorkers(),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.assignedWorkers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 5.5,
                                  vertical: SizeConfig.heightMultiplier * 1.2),
                              child: Obx(
                                () => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 1,
                                      vertical:
                                          SizeConfig.heightMultiplier * 1.2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: lightBlueGreyColor)),
                                      color: checkWorkerForceIfSelected(
                                              selectedAssignedWorkers:
                                                  controller
                                                      .selectedAssignedWorkers,
                                              workerToCheck: controller
                                                  .assignedWorkers[index])
                                          ? textFormColor
                                          : whiteColor),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            controller.selectedAssignedWorkers
                                                    .contains(controller
                                                        .assignedWorkers[index])
                                                ? GestureDetector(
                                                    onTap: () =>
                                                        controller.addWorker(
                                                            toAdd: controller
                                                                    .assignedWorkers[
                                                                index]),
                                                    child: Container(
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          7,
                                                      width: SizeConfig
                                                              .widthMultiplier *
                                                          16,
                                                      decoration: BoxDecoration(
                                                          color: blueDark,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Center(
                                                        child: SvgPicture.asset(
                                                          Images.selectIcon,
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              1.5,
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              4,
                                                          color: whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () =>
                                                        controller.addWorker(
                                                            toAdd: controller
                                                                    .assignedWorkers[
                                                                index]),
                                                    child: Container(
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          7,
                                                      width: SizeConfig
                                                              .widthMultiplier *
                                                          16,
                                                      decoration: BoxDecoration(
                                                          color: textFormColor,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Center(
                                                        child: Text(
                                                          "${controller.assignedWorkers[index].firstName![0].toString().toUpperCase()}${controller.assignedWorkers[index].lastName![0].toString().toUpperCase()}",
                                                          style: TextStyling
                                                              .formBlueTextStyle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      3,
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () => Get.toNamed(
                                                    RouteLinks
                                                        .homeWorkerProfile,
                                                    arguments: {
                                                      "assigned_worker_id":
                                                          controller
                                                              .assignedWorkers[
                                                                  index]
                                                              .assignedWorkerId,
                                                      "worker_id": controller
                                                          .assignedWorkers[
                                                              index]
                                                          .workerId,
                                                      "project": project,
                                                      "worker_name":
                                                          "${nameCapitalised(controller.assignedWorkers[index].firstName)} ${nameCapitalised(controller.assignedWorkers[index].lastName)}"
                                                    }),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${nameCapitalised(controller.assignedWorkers[index].firstName)} ${nameCapitalised(controller.assignedWorkers[index].lastName)}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyling
                                                          .normalBoldTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          0.6,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2.0),
                                                      child: Text(
                                                          "${controller.assignedWorkers[index].nidNumber}",
                                                          style: TextStyling
                                                              .formGreyTextStyle),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          0.6,
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          3,
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 2.0),
                                                            child: Text(
                                                                "${controller.assignedWorkers[index].phoneNumber}",
                                                                style: TextStyling
                                                                    .formGreyTextStyle),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .widthMultiplier *
                                                                1.5,
                                                          ),
                                                          parseBool(
                                                                  isVerified: controller
                                                                      .assignedWorkers[
                                                                          index]
                                                                      .isVerified!)
                                                              ? SvgPicture
                                                                  .asset(
                                                                  Images
                                                                      .isVerifiedIcon,
                                                                  height: SizeConfig
                                                                          .heightMultiplier *
                                                                      1.8,
                                                                  color:
                                                                      greenColor,
                                                                )
                                                              : Container(),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .widthMultiplier *
                                                                1.5,
                                                          ),
                                                          ListView.builder(
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis
                                                                      .horizontal,
                                                              itemCount: getServiceRates(
                                                                      services: controller
                                                                          .assignedWorkers[
                                                                              index]
                                                                          .services!,
                                                                      servicesList:
                                                                          project
                                                                              .services!)
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      idex) {
                                                                var service = getServiceRates(
                                                                    services: controller
                                                                        .assignedWorkers[
                                                                            index]
                                                                        .services!,
                                                                    servicesList:
                                                                        project
                                                                            .services!)[idex];
                                                                return Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          SizeConfig.widthMultiplier *
                                                                              1.5),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            textFormColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: SizeConfig.widthMultiplier *
                                                                              1.5,
                                                                          vertical:
                                                                              SizeConfig.heightMultiplier * 0.3),
                                                                      child:
                                                                          Text(
                                                                        service[
                                                                            "service_name"],
                                                                        style: TextStyling
                                                                            .blueSmallTextStyle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Spacer(),
                                            SizedBox(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      3,
                                            ),
                                            SvgPicture.asset(
                                              Images.moreIcon,
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.6,
                                              color: lightBlueGreyColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      // Divider(
                                      //   thickness: 0.5,
                                      //   color: lightBlueGreyColor,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )),
                ],
              ),
            ));
          }),
    );
  }

  _selectedWorkers() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text.rich(
          TextSpan(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextSpan(
                text: "(${controller.selectedAssignedWorkers.length} ",
                style: TextStyling.normalBoldTextStyle,
              ),
              TextSpan(
                text: "/${assignedWorkers.length})",
                style: TextStyling.normalBoldTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showMessageModal({required BuildContext context}) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Send Message",
                          style: TextStyling.normalBoldTextStyle,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(
                            Images.timesIcon,
                            color: appBarColorText,
                            height: SizeConfig.heightMultiplier * 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: Text(
                        "Send Message to ${controller.selectedAssignedWorkers.length} worker(s)",
                        style: TextStyling.formGreyTextStyle),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: Text(
                      "Message",
                      style: TextStyling.normalBoldTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: Container(
                      // height: SizeConfig.heightMultiplier * 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: greyLightColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller.sms.value,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 5,
                          autocorrect: false,
                          validator: (value) {
                            return value!.isEmpty ? "Insert a message" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter text here",
                            border: InputBorder.none,
                            fillColor: whiteColor,
                            filled: true,
                            hintStyle: TextStyling.formTextStyle,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.sendMessage();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 3),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: SizeConfig.heightMultiplier * 5,
                            width: SizeConfig.widthMultiplier * 15,
                            decoration: BoxDecoration(
                                color: blueColorText,
                                borderRadius: BorderRadius.circular(4)),
                            child: controller.issmsLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: whiteColor,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "Send",
                                      style:
                                          TextStyling.nameWhiteProfileTextStyle,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showBottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.8,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 27),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFormBorderColor,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Center(
                    child: controller.selectedAssignedWorkers.length > 1
                        ? Text(
                            "Bulk Action to the ${controller.selectedAssignedWorkers.length} selected workers",
                            style: TextStyling.formGreyTextStyle)
                        : Text(
                            "Bulk Action to the ${controller.selectedAssignedWorkers.length} selected worker",
                            style: TextStyling.formGreyTextStyle),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  GestureDetector(
                    onTap: () => _showMessageModal(context: context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Images.smsIcon,
                          color: blackColor,
                          // height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Text(
                          "Send message",
                          style: TextStyling.normalBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _appBar({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 1.5),
      child: Obx(() => Container(
            height: SizeConfig.heightMultiplier * 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 12, right: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 2.5),
                      height: SizeConfig.heightMultiplier * 6,
                      width: SizeConfig.widthMultiplier * 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: SvgPicture.asset(
                        Images.leftArrowIcon,
                        // height: SizeConfig.heightMultiplier * 2,
                        color: appBarColorText,
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier * 3),
                  Expanded(
                    child: TextFormField(
                      // controller: textController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          controller.searchWorkers(
                              data: value.toLowerCase(), isEmpty: true);
                        } else {
                          controller.searchWorkers(
                              data: value.toLowerCase(), isEmpty: false);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search by name, phone or ID",
                        border: InputBorder.none,
                        hintStyle: TextStyling.formTextStyle,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier * 3),
                  controller.selectedAssignedWorkers.isNotEmpty
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _showBottomSheet(context: context),
                          child: Container(
                            width: SizeConfig.widthMultiplier * 8,
                            child: SvgPicture.asset(
                              Images.moreIcon,
                              color: appBarColorText,
                              height: SizeConfig.widthMultiplier * 3,
                            ),
                          ),
                        )
                      : SvgPicture.asset(
                          Images.searchIcon,
                          color: appBarColorText,
                          width: SizeConfig.widthMultiplier * 4,
                        )
                ],
              ),
            ),
          )),
    );
  }
}
