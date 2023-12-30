import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/training_course.dart';

import '../../../config/config.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import 'upload_course.dart';

class WebView2 extends StatefulWidget {
  const WebView2(this.article);

  final TrainingCourse article;

  @override
  State<WebView2> createState() => _WebView2State();
}

class _WebView2State extends State<WebView2> {
  var formKey = GlobalKey<FormState>();

  TextEditingController courseDaysCtrl = TextEditingController();
  TextEditingController courseHoursCtrl = TextEditingController();
  TextEditingController courseBeginningDateCtrl = TextEditingController();
  TextEditingController courseEndingDateCtrl = TextEditingController();
  TextEditingController availableFromCtrl = TextEditingController();
  TextEditingController availableToCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        Config().initialCategories[0],
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration(
                        'Course days'.tr(), 'Days'.tr(), courseDaysCtrl),
                    controller: courseDaysCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration(
                        'Course hours'.tr(), 'Hours'.tr(), courseHoursCtrl),
                    controller: courseHoursCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      _getDate(context, courseBeginningDateCtrl);
                    },
                    decoration: inputDecoration('Enter beginning date'.tr(),
                        'Beginning date'.tr(), courseBeginningDateCtrl),
                    controller: courseBeginningDateCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      _getDate(context, courseEndingDateCtrl);
                    },
                    decoration: inputDecoration('Enter ending date'.tr(),
                        'Ending date'.tr(), courseEndingDateCtrl),
                    controller: courseEndingDateCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      _getDate(context, availableFromCtrl);
                    },
                    decoration: inputDecoration('From'.tr(),
                        'Available From Date'.tr(), availableFromCtrl),
                    controller: availableFromCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      _getDate(context, availableToCtrl);
                    },
                    decoration: inputDecoration(
                        'To'.tr(), 'Available To Date'.tr(), availableToCtrl),
                    controller: availableToCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                        color: ColorManager.success,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        child: Text(
                          'Next'.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UploadCourse(
                                  article: widget.article.copyWith(
                                    courseDays: int.parse(courseDaysCtrl.text),
                                    courseHours:
                                        int.parse(courseHoursCtrl.text),
                                    courseBeginningDate:
                                        courseBeginningDateCtrl.text,
                                    courseEndingDate: courseEndingDateCtrl.text,
                                    availableFrom: availableFromCtrl.text,
                                    availableTo: availableToCtrl.text,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getDate(BuildContext context, TextEditingController controller) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.parse("${DateTime.now().year + 9}-01-01"))
        .then((value) {
      if (value != null) controller.text = value.toString().substring(0, 10);
    });
  }
}
