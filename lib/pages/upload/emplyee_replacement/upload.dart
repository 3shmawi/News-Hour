import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/employee_replacement.dart';
import 'package:provider/provider.dart';
import '../../../blocs/sign_in_bloc.dart';
import '../../../config/config.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/styles.dart';

/*
طبيب بجدة-يرغب ببديل أو بديلة بجدة
محمد عشماوي
https://images.unsplash.com/photo-1488372759477-a7f4aa078cb6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60
بديل أو بديلة
الطائف
جدة
أخصائية أشعة
mohamedashmawy918@gmail.com
 */
class UploadEmployeeReplacement extends StatefulWidget {
  const UploadEmployeeReplacement({Key? key}) : super(key: key);

  @override
  _UploadEmployeeReplacementState createState() =>
      _UploadEmployeeReplacementState();
}

class _UploadEmployeeReplacementState extends State<UploadEmployeeReplacement> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var formKey = GlobalKey<FormState>();

  var titleCtrl = TextEditingController();
  var mediaUrlCtrl = TextEditingController();
  var availableFromCtrl = TextEditingController();
  var availableToCtrl = TextEditingController();
  var currentPositionCtrl = TextEditingController();
  var neededPositionCtrl = TextEditingController();
  var searchForCtrl = TextEditingController();
  var jobTypeCtrl = TextEditingController();
  var jobCityCtrl = TextEditingController();
  var jobAddressCtrl = TextEditingController();
  var organizationNameCtrl = TextEditingController();

  var descriptionCtrl = TextEditingController();
  var setsCountCtrl = TextEditingController();
  var websiteCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var whatsAppCtrl = TextEditingController();
  var telegramCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool? notifyUsers = true;
  bool uploadStarted = false;
  bool? uploadStartedonDrafts = false;
  String? _timestamp;
  String? _date;
  var _articleData;

  var categorySelection;

  void handleSubmit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() => uploadStarted = true);
      await getDate().then((_) async {
        await saveToDatabase().then((value) {
          _clearTextFields();

          setState(() {
            uploadStarted = false;
          });
          Navigator.of(context).pop();
          openDialog(context, 'Uploaded Successfully',
              'Waiting one of admin will review it...');
        });
      });
    }
  }

  Future getDate() async {
    DateTime now = DateTime.now();
    String _d = DateFormat('dd MMMM yy').format(now);
    String _t = DateFormat('yyyyMMddHHmmss').format(now);
    setState(() {
      _timestamp = _t;
      _date = _d;
    });
  }

  Future saveToDatabase() async {
    final DocumentReference ref = firestore
       .collection('emp_replace')
        .doc(_timestamp);
    _articleData = EmployeeReplacement(
      isPublished: true,
      title: titleCtrl.text,
      availableTo: availableToCtrl.text,
      availableFrom: availableFromCtrl.text,
      createdBy: Provider.of<SignInBloc>(context, listen: false).name?? "",
      currentPosition: currentPositionCtrl.text,
      neededPosition: neededPositionCtrl.text,
      jobAddress: jobAddressCtrl.text,
      jobCity: jobCityCtrl.text,
      jobType: jobTypeCtrl.text,
      organizationName: organizationNameCtrl.text,
      searchFor: searchForCtrl.text,
      mediaUrl: mediaUrlCtrl.text,
      description: _isNull(descriptionCtrl.text),
      creationDate: _date!,
      timestamp: _timestamp,
      phone: _isNull(phoneCtrl.text),
      telegram: _isNull(telegramCtrl.text),
      website: _isNull(websiteCtrl.text),
      whatsApp: _isNull(whatsAppCtrl.text),
      email: _isNull(emailCtrl.text),
    ).toFireStore();

    await ref.set(_articleData);
  }

//
  //خدمة مدنية
  //
  //مستشفى الثغر بجدة
  _clearTextFields() {
    titleCtrl.clear();
    mediaUrlCtrl.clear();
    availableFromCtrl.clear();
    availableToCtrl.clear();
    currentPositionCtrl.clear();
    neededPositionCtrl.clear();
    searchForCtrl.clear();
    jobTypeCtrl.clear();
    jobCityCtrl.clear();
    jobAddressCtrl.clear();
    organizationNameCtrl.clear();

    descriptionCtrl.clear();
    setsCountCtrl.clear();
    websiteCtrl.clear();
    emailCtrl.clear();
    whatsAppCtrl.clear();
    telegramCtrl.clear();
    phoneCtrl.clear();

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
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
                        Config().initialCategories[5],
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
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    decoration: inputDecoration('Enter Course Image Url'.tr(),
                        'Course Image Url'.tr(), mediaUrlCtrl),
                    controller: mediaUrlCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Divider(thickness: 2),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Divider(thickness: 2),
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Current Position'.tr(),
                        'Current Position'.tr(), currentPositionCtrl),
                    controller: currentPositionCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Needed Position'.tr(),
                        'Needed Position'.tr(), neededPositionCtrl),
                    controller: neededPositionCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Divider(thickness: 2),
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Search For'.tr(),
                        'Search For'.tr(), searchForCtrl),
                    controller: searchForCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Organization Name'.tr(),
                        'Organization Name'.tr(), organizationNameCtrl),
                    controller: organizationNameCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Divider(thickness: 2),
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Jop Address'.tr(),
                        'Jop Address'.tr(), jobAddressCtrl),
                    controller: jobAddressCtrl,
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
                        'Enter Job City'.tr(), 'Job City'.tr(), jobCityCtrl),
                    controller: jobCityCtrl,
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
                        'Enter Job Type'.tr(), 'Job Type'.tr(), jobTypeCtrl),
                    controller: jobTypeCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Divider(thickness: 2),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Description (optional)'.tr(),
                      border: OutlineInputBorder(),
                      labelText: 'Description'.tr(),
                      contentPadding: EdgeInsets.only(
                          right: 0, left: 10, top: 0, bottom: 5),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            icon: Icon(Icons.close, size: 15),
                            onPressed: () {
                              descriptionCtrl.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                    textAlignVertical: TextAlignVertical.top,
                    minLines: 5,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionCtrl,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter whatsapp number'.tr(),
                        'Whatsapp number (optional)'.tr(), whatsAppCtrl),
                    controller: whatsAppCtrl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter telegram url'.tr(),
                        'Telegram Url (optional)'.tr(), telegramCtrl),
                    controller: telegramCtrl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Website Url'.tr(),
                        'Website Url (optional)'.tr(), websiteCtrl),
                    controller: websiteCtrl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Phone Number'.tr(),
                        'Phone number (optional)'.tr(), phoneCtrl),
                    controller: phoneCtrl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter Email Address'.tr(),
                        'Email Address (optional)'.tr(), emailCtrl),
                    controller: emailCtrl,
                  ),
                  SizedBox(
                    height: 20,
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
                      child: uploadStarted == true
                          ? Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : TextButton(
                              child: Text(
                                'Publish Now'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () async {
                                handleSubmit();
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

  String? _isNull(String v) {
    if (v == '') {
      return null;
    }
    return v;
  }
}
