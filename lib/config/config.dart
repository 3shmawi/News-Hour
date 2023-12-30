import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/colors.dart';

class Config{

  
  final String appName = 'Kader'.tr();
  final String splashIcon = 'assets/images/icon.png';
  // final String supportEmail = '3shmawiii@gmail.com';
   final String support = 'https://kader.com.co/';
  final String privacyPolicyUrl = 'https://www.freeprivacypolicy.com/live/c52ae93e-4f69-4532-8985-9a7e4fcce4d5';
  final String ourWebsiteUrl = 'https://kader.com.co/';
  final String iOSAppId = '000000';

  
  //social links
  static const String facebookPageUrl = 'https://www.facebook.com/mrblab24';
  static const String youtubeChannelUrl = 'https://www.youtube.com/channel/UCnNr2eppWVVo-NpRIy1ra7A';
  static const String twitterUrl = 'https://twitter.com/FlutterDev';
  
  //app theme color
  final Color appColor = ColorManager.def;



  //Intro images
  final String introImage1 = 'assets/images/news1.png';
  final String introImage2 = 'assets/images/news6.png';
  final String introImage3 = 'assets/images/news7.png';

  //animation files
  final String doneAsset = 'assets/animation_files/done.json';

  
  //Language Setup
  final List<String> languages = [
    'English',
    'Arabic'
  ];


  //initial categories - 4 only (Hard Coded : which are added already on your admin panel)
  final List initialCategories = [
    'الدورات التدريبية',
    'العروض',
    'الفعاليات',
    'الوظائف الطبية',
    'منوعات',
    'النقل ببديل',
    'الرعاة',
  ];


  final String serverToken = 'AAAAEzdOsf4:APA91bEiEWJKN6JxvBCdc9Eo21hf-pErwZiluApmiEG-Ox7cM13t984xBDs1ilZccn5Hv3uh2GzsYp9bYKhO1dA46QgpYVEm3LjvkKk89GtUASSSXojK3hlCas0h9jyLUiTn81jWh9ur';




  //don't edit or remove this
  final List contentTypes = [
    'Limited Sets',
    'Un Limited Sets',
  ];
}