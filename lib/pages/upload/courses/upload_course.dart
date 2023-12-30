import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/training_course.dart';
import 'package:provider/provider.dart';
import '../../../blocs/admin_bloc.dart';
import '../../../config/config.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/styles.dart';

class UploadCourse extends StatefulWidget {
  const UploadCourse({required this.article, Key? key}) : super(key: key);

  final TrainingCourse article;

  @override
  _UploadCourseState createState() => _UploadCourseState();
}

class _UploadCourseState extends State<UploadCourse> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var formKey = GlobalKey<FormState>();

  var descriptionCtrl = TextEditingController();
  var accreditedEntitiesCtrl = TextEditingController();
  var setsCountCtrl = TextEditingController();
  var websiteCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var whatsAppCtrl = TextEditingController();
  var telegramCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var registrationLinkCtrl = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool? notifyUsers = true;
  bool uploadStarted = false;
  bool? uploadStartedonDrafts = false;
  String? _timestamp;
  String? _date;
  var _articleData;

  var categorySelection;

  void handleSubmit() async {
    setState(() => uploadStarted = true);
    await getDate().then((_) async {
      await saveToDatabase()
          .then((value) =>
              context.read<AdminBloc>().increaseCount('contents_count'))
          .then((value) => context
                  .read<AdminBloc>()
                  .increaseCount('drafts_count')
                  .then((value) {
                setState(() {
                  uploadStarted = false;
                });
                _clearTextFields();

                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                openDialog(context, 'Uploaded Successfully',
                    'Waiting one of admin will review it...',);
              }));
    });
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
    final DocumentReference ref =
        firestore.collection('contents').doc(_timestamp);
    _articleData = widget.article
        .copyWith(
          description: _isNull(descriptionCtrl.text),
          loves: 0,
          views: 0,
          creationDate: _date,
          timestamp: _timestamp,
          accreditedEntities: _isNull(accreditedEntitiesCtrl.text),
          phone: _isNull(phoneCtrl.text),
          setsCount:
              setsCountCtrl.text == '' ? null : int.parse(setsCountCtrl.text),
          telegram: _isNull(telegramCtrl.text),
          website: _isNull(websiteCtrl.text),
          whatsApp: _isNull(whatsAppCtrl.text),
          registrationLink: _isNull(registrationLinkCtrl.text),
          email: _isNull(emailCtrl.text),
        )
        .toFireStore();

    await ref.set(_articleData);
  }

  _clearTextFields() {
    descriptionCtrl.clear();
    accreditedEntitiesCtrl.clear();
    setsCountCtrl.clear();
    websiteCtrl.clear();
    whatsAppCtrl.clear();
    telegramCtrl.clear();
    phoneCtrl.clear();
    registrationLinkCtrl.clear();

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
                      Config().initialCategories[0],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: inputDecoration(
                      'Registration Link (optional)'.tr(),
                      'Registration Link'.tr(),
                      registrationLinkCtrl),
                  controller: registrationLinkCtrl,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Description (optional)'.tr(),
                    border: OutlineInputBorder(),
                    labelText: 'Description'.tr(),
                    contentPadding:
                        EdgeInsets.only(right: 0, left: 10, top: 15, bottom: 5),
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
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: inputDecoration('Enter Sets Count'.tr(),
                      'Sets Count (optional)'.tr(), setsCountCtrl),
                  controller: setsCountCtrl,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: inputDecoration(
                      'Enter Accredited Entities'.tr(),
                      'Accredited Entities (optional)'.tr(),
                      accreditedEntitiesCtrl),
                  controller: accreditedEntitiesCtrl,
                ),
                SizedBox(
                  height: 20,
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
    );
  }

  String? _isNull(String v) {
    if (v == '') {
      return null;
    }
    return v;
  }
}
