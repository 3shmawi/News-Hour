import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:launch_review/launch_review.dart';
import 'package:news_app/blocs/sign_in_bloc.dart';
import 'package:news_app/blocs/theme_bloc.dart';
import 'package:news_app/config/config.dart';
import 'package:reading_time/reading_time.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:news_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppService {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool?> checkInternet() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        internet = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      internet = false;
    }
    return internet;
  }
  
  Future openLink(context, String url) async {
    final uri = Uri.parse(url);
    if (await urlLauncher.canLaunchUrl(uri)) {
      urlLauncher.launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      openToast1(context, "Can't launch the url");
    }
  }
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await urlLauncher.launchUrl(launchUri);
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await urlLauncher.launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> whatsapp(String whatsapp) async{
    var contact = whatsapp;
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try{
      if(Platform.isIOS){
        await urlLauncher.launchUrl(Uri.parse(iosUrl));
      }
      else{
        await urlLauncher.launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
      throw Exception('Could not launch ');
    }
  }
  Future openEmailSupport(context,String email) async {

    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=About ${Config().appName}&body=', //add subject and body here
    );

    if (await urlLauncher.canLaunchUrl(uri)) {
      await urlLauncher.launchUrl(uri);
    } else {
      openToast1(context, "Can't open the email app");
    }
  }




  Future openLinkWithCustomTab(BuildContext context, String url) async {
    try{
      await FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        colorScheme: context.read<ThemeBloc>().darkTheme! ? CustomTabsColorScheme.dark : CustomTabsColorScheme.light,
        //addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
    }catch(e){
      openToast1(context, 'Cant launch the url');
      debugPrint(e.toString());
    }
  }



  Future launchAppReview(context) async {
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await LaunchReview.launch(
        androidAppId: sb.packageName,
        iOSAppId: Config().iOSAppId,
        writeReview: false);
    if (Platform.isIOS) {
      if (Config().iOSAppId == '000000') {
        openToast1(context, 'The iOS version is not available on the AppStore yet');
      }
    }
  }



  static getNormalText (String text){
    return HtmlUnescape().convert(parse(text).documentElement!.text);
  }

  static getReadingTime (String text){
    var reader = readingTime(getNormalText(text));
    return reader.msg;
  }

  Future<bool?> checkAdminAccount (String uid) async{
    bool? isAdmin;
    await _firebaseFirestore.collection('users').doc(uid).get().then((DocumentSnapshot snap){
      if(snap.exists){
        List? userRole = snap['role'];
        debugPrint('User Role: $userRole');
        if(userRole != null && userRole.contains('admin')){
          isAdmin = true;
        }else{
          isAdmin = false;
        }
      }else{
        isAdmin = false;
      }
    }).catchError((e){
      isAdmin = false;
      debugPrint('check admin error: $e');
    });
    return isAdmin;
  }

}