// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class HomeNewAssessment extends GetWidget<HomeAssessWorkerController> {
  final String workerFullName;
  final int assignedWorkerId;
  final int workerId;
  final int serviceId;
  final int projectId;
  final bool attendance;
  HomeNewAssessment(
      {Key? key,
      required this.workerFullName,
      required this.assignedWorkerId,
      required this.serviceId,
      required this.attendance,
      required this.projectId,
      required this.workerId})
      : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GetBuilder(
          init: HomeAssessWorkerController(),
          initState: (_) => controller.getAssessmentsQuestions(
              workerId: workerId,
              workerProjectId: projectId,
              assignedWorkerId: assignedWorkerId),
          builder: (cons) {
            return SafeArea(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 8),
                    child: _appBar(text: "Assessment Level"),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: Text(
                      "Rate $workerFullName",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyling.nameProfileTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  controller.isLoading
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 1.5),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 2,
                                horizontal: SizeConfig.widthMultiplier * 8),
                            margin: EdgeInsets.symmetric(
                                // vertical: SizeConfig.heightMultiplier * 2,
                                horizontal: SizeConfig.widthMultiplier * 4),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: lightGreyColor,
                                    spreadRadius: 1.2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Choose service',
                                  maxLines: 2,
                                  style: TextStyling.nameProfileTextStyle,
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 1.5,
                                ),
                                DropdownButtonFormField<ServicesInfo>(
                                    icon:  Icon(
                                      Icons.arrow_drop_down,
                                      color: blackColor,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: whiteColor,
                                      hintStyle: TextStyling.formTextStyle,
                                      filled: true,
                                      hintText: 'Select a service',
                                    ),
                                    items: controller.workerProfile
                                        .workerInformation!.services!
                                        .map((val) =>
                                            DropdownMenuItem<ServicesInfo>(
                                              child: Text(val.name!),
                                              value: val,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      controller.getService(
                                          servcId: value!.serviceId!);
                                    }),
                              ],
                            ),
                          )),
                  controller.isLoading
                      ? Container(
                          // height: SizeConfig.heightMultiplier * 40,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              topLeft: Radius.circular(24),
                            ),
                          ),
                          child: lottieLoading(sizeConfigHeight: 16),
                        )
                      : Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.dataTest.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            SizeConfig.heightMultiplier * 1.5),
                                    child: _assessmentContainer(
                                        metricId:
                                            controller.dataTest[index].metricId,
                                        question:
                                            '${controller.dataTest[index].question}',
                                        description:
                                            '${controller.dataTest[index].description}',
                                        percentage: controller
                                            .dataTest[index].percentage,
                                        status:
                                            controller.dataTest[index].status));
                              })),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        // vertical: SizeConfig.heightMultiplier * 2,
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.heightMultiplier * 1.5,
                                  horizontal: SizeConfig.widthMultiplier * 5.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: whiteColor,
                                border: Border.all(color: greyLightColor),
                              ),
                              child: Center(
                                child: Text("Cancel",
                                    style: TextStyling
                                        .buttonGreyedAssessmentTextStyle),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 4,
                        ),
                        controller.isLoadingSubmit
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: blueDark,
                                ),
                              )
                            : Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    final isValid =
                                        _formKey.currentState!.validate();
                                    if (isValid) {
                                      controller.submit(
                                          status: attendance,
                                          assignedWorkerId: assignedWorkerId,
                                          context: context,
                                          projectId: projectId,
                                          workerId: workerId);
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            SizeConfig.heightMultiplier * 1.5,
                                        horizontal:
                                            SizeConfig.widthMultiplier * 5.5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: blueDark,
                                      border: Border.all(color: greyLightColor),
                                    ),
                                    child: Center(
                                      child: Text("Submit",
                                          style:
                                              TextStyling.buttonWhiteTextStyle),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                ],
              ),
            ));
          }),
    );
  }

  _assessmentContainer(
      {required String question,
      required int metricId,
      required String description,
      required int percentage,
      required bool status}) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 2,
          horizontal: SizeConfig.widthMultiplier * 8),
      margin: EdgeInsets.symmetric(
          // vertical: SizeConfig.heightMultiplier * 2,
          horizontal: SizeConfig.widthMultiplier * 4),
      decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              spreadRadius: 1.2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$question',
            maxLines: 2,
            style: TextStyling.nameProfileTextStyle,
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 1.5,
          ),
          Text("$description",
              style: TextStyling.buttonGreyedAssessmentTextStyle),
          SizedBox(
            height: SizeConfig.heightMultiplier * 1.5,
          ),
          status
              ? Text(
                  '$percentage %',
                  style: TextStyling.nameProfileTextStyle,
                )
              : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: greyLightColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(1.2),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          controller.setAnswer(text: value, metricId: metricId),
                      autocorrect: false,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            checkIfRankIsInRange(meanScore: int.parse(value))) {
                          return 'Allowed value must be from 0 up to 100';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter rate between 0-100%",
                        border: InputBorder.none,
                        fillColor: whiteColor,
                        filled: true,
                        hintStyle: TextStyling.formTextStyle,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _appBar({required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            Images.leftArrowIcon,
            color: appBarColorText,
            width: SizeConfig.widthMultiplier * 4,
          ),
        ),
        Text(text, style: TextStyling.nameProfileTextStyle),
        SvgPicture.asset(
          Images.searchIcon,
          color: whiteColor,
          width: SizeConfig.widthMultiplier * 4,
        ),
      ],
    );
  }
}
