import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
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
class UploadMix extends StatefulWidget {
  const UploadMix({Key? key}) : super(key: key);

  @override
  _UploadMixState createState() => _UploadMixState();
}

class _UploadMixState extends State<UploadMix> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var formKey = GlobalKey<FormState>();

  var titleCtrl = TextEditingController();
  var mediaUrlCtrl = TextEditingController();
  var whatsAppCtrl = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool uploadStarted = false;
  String? _timestamp;
  String? _date;
  var _articleData;

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
    final DocumentReference ref = firestore.collection('mix').doc(_timestamp);
    _articleData = MixModel(
      isPublished: true,
      title: titleCtrl.text,
      createdBy: Provider.of<SignInBloc>(context, listen: false).name ?? "",
      mediaUrl: mediaUrlCtrl.text,
      creationDate: _date!,
      timestamp: _timestamp,
      whatsApp: whatsAppCtrl.text,
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

    whatsAppCtrl.clear();

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
                        Config().initialCategories[4],
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
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    decoration: inputDecoration('Enter whatsapp number'.tr(),
                        'Whatsapp number (optional)'.tr(), whatsAppCtrl),
                    controller: whatsAppCtrl,
                    validator: (value) {
                      if (value!.isEmpty) return 'Value is empty'.tr();
                      return null;
                    },
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
}
