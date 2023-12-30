import 'package:flutter/material.dart';

class Config{

  
  final String appName = 'NewsHour';
  final String splashIcon = 'assets/images/splash.png';
  final String supportEmail = '3shmawiii@gmail.com';
  final String privacyPolicyUrl = '';
  final String ourWebsiteUrl = '';
  final String iOSAppId = '000000';

  
  //social links
  static const String facebookPageUrl = '';
  static const String youtubeChannelUrl = '';
  static const String twitterUrl = '';
  
  //app theme color
  final Color appColor = Colors.deepPurpleAccent;



  //Intro images
  final String introImage1 = 'assets/images/news1.png';
  final String introImage2 = 'assets/images/news6.png';
  final String introImage3 = 'assets/images/news7.png';

  //animation files
  final String doneAsset = 'assets/animation_files/done.json';

  
  //Language Setup
  final List<String> languages = [
    'English',
    'Spanish',
    'Arabic'
  ];


  //initial categories - 4 only (Hard Coded : which are added already on your admin panel)
  final List initialCategories = [
    'Entertainment',
    'Sports',
    'Politics',
    'Travel'
  ];
}