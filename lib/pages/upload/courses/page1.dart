import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/training_course.dart';
import 'package:news_app/pages/upload/courses/page2.dart';
import 'package:news_app/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../blocs/sign_in_bloc.dart';
import '../../../config/config.dart';
import '../../../utils/styles.dart';

class WebView1 extends StatefulWidget {
  const WebView1();

  @override
  State<WebView1> createState() => _WebView1State();
}

class _WebView1State extends State<WebView1> {
  var formKey = GlobalKey<FormState>();

  TextEditingController titleCtrl = TextEditingController();

  TextEditingController organizedByCtrl = TextEditingController();

  TextEditingController imageUrlCtrl = TextEditingController();
  TextEditingController hasOfferCtrl = TextEditingController();

  bool limitedSets = false;
  bool isMedJob = false;
  bool hasOffer = false;

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
                        'enter title'.tr(), 'title'.tr(), titleCtrl),
                    controller: titleCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Organized By'.tr(),
                        'Organized By'.tr(), organizedByCtrl),
                    controller: organizedByCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Course Image Url'.tr(),
                        'Course Image Url'.tr(), imageUrlCtrl),
                    controller: imageUrlCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'med job'.tr(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Switch(
                        value: isMedJob,
                        onChanged: (v) {
                          setState(() {
                            isMedJob = v;
                          });
                        },
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'limited sets'.tr(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Switch(
                        value: limitedSets,
                        onChanged: (v) {
                          setState(() {
                            limitedSets = v;
                          });
                        },
                      ),
                      Spacer(),
                      Text(
                        'has offer'.tr(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Switch(
                        value: hasOffer,
                        onChanged: (v) {
                          setState(() {
                            hasOffer = v;
                          });
                        },
                      ),
                    ],
                  ),
                  if (hasOffer)
                    TextFormField(
                      decoration: inputDecoration(
                          'has offer'.tr(), 'has offer'.tr(), hasOfferCtrl),
                      controller: hasOfferCtrl,
                      validator: (value) {
                        if (value!.isEmpty) return 'Value is empty'.tr();
                        return null;
                      },
                    ),
                  SizedBox(
                    height: 10,
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
                                builder: (context) => WebView2(
                                  TrainingCourse(
                                    isMedicalJob: isMedJob,
                                    isPublished: false,
                                    hasOffer: hasOfferCtrl.text == ''
                                        ? null
                                        : hasOfferCtrl.text,
                                    title: titleCtrl.text,
                                    mediaUrl: imageUrlCtrl.text,
                                    createdBy:
                                        context.watch<SignInBloc>().name ?? "",
                                    limitedSets: limitedSets,
                                    organizedBy: organizedByCtrl.text,
                                    creationDate: "",
                                    availableFrom: "",
                                    availableTo: "",
                                    courseDays: 0,
                                    courseHours: 0,
                                    courseBeginningDate: "",
                                    courseEndingDate: "",
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
}
