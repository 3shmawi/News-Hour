import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingCourse {
  bool isPublished;
  String? hasOffer;
  String title;
  String mediaUrl;
  String createdBy;
  String creationDate;
  String availableFrom;
  String availableTo;
  bool limitedSets;
  bool isMedicalJob;
  int courseDays;
  int courseHours;
  String courseBeginningDate;
  String courseEndingDate;
  String organizedBy;
  String? description;
  String? registrationLink;
  int? setsCount;
  String? accreditedEntities;
  String? phone;
  String? website;
  String? whatsApp;
  String? telegram;
  String? email;

  //article
  int? loves;
  String? timestamp;
  int? views;

  TrainingCourse({
    required this.isPublished,
    required this.title,
    required this.mediaUrl,
    required this.createdBy,
    required this.creationDate,
    required this.availableFrom,
    required this.availableTo,
    required this.limitedSets,
    required this.isMedicalJob,
    required this.courseDays,
    required this.courseHours,
    required this.courseBeginningDate,
    required this.courseEndingDate,
    required this.organizedBy,
    this.accreditedEntities,
    this.registrationLink,
    this.description,
    this.setsCount,
    this.website,
    this.whatsApp,
    this.telegram,
    this.phone,
    this.email,
    this.loves,
    this.timestamp,
    this.views,
    this.hasOffer,
  });

  factory TrainingCourse.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return TrainingCourse(
      isPublished: d['isPublished'],
      title: d['title'],
      mediaUrl: d['media_url'],
      createdBy: d['cre_by'],
      creationDate: d['cre_date'],
      availableFrom: d['av_from'],
      availableTo: d['av_to'],
      limitedSets: d['lim_sets'],
      isMedicalJob: d['med_job'],
      courseDays: d['c_days'],
      courseHours: d['c_hours'],
      courseBeginningDate: d['c_b_date'],
      courseEndingDate: d['c_e_date'],
      organizedBy: d['o_by'],
      accreditedEntities: d['ac_entities'],
      description: d['desc'],
      phone: d['phone'],
      registrationLink: d['re_link'],
      setsCount: d['sets_count'],
      telegram: d['telegram'],
      website: d['website'],
      whatsApp: d['w_app'],
      email: d['email'],
      loves: d['loves'],
      views: d['views'] ?? 0,
      timestamp: d['timestamp'],
      hasOffer: d['hasOffer'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'isPublished': this.isPublished,
      'media_url': this.mediaUrl,
      'title': this.title,
      'desc': this.description,
      'loves': this.loves,
      're_link': this.registrationLink,
      'cre_date': this.creationDate,
      'timestamp': this.timestamp,
      'views': this.views,
      'cre_by': this.createdBy,
      'av_from': this.availableFrom,
      'av_to': this.availableTo,
      'lim_sets': this.limitedSets,
      'med_job': this.isMedicalJob,
      'c_days': this.courseDays,
      'c_hours': this.courseHours,
      'c_b_date': this.courseBeginningDate,
      'c_e_date': this.courseEndingDate,
      'o_by': this.organizedBy,
      'ac_entities': this.accreditedEntities,
      'phone': this.phone,
      'sets_count': this.setsCount,
      'telegram': this.telegram,
      'website': this.website,
      'w_app': this.whatsApp,
      'email': this.email,
      'hasOffer': this.hasOffer,
    };
  }

  TrainingCourse copyWith({
    bool? isPublished,
    String? title,
    String? mediaUrl,
    String? createdBy,
    String? creationDate,
    String? availableFrom,
    String? availableTo,
    bool? limitedSets,
    bool? isMedJob,
    int? courseDays,
    int? courseHours,
    String? courseBeginningDate,
    String? courseEndingDate,
    String? organizedBy,
    String? timestamp,
    int? views,
    int? loves,
    String? website,
    String? telegram,
    int? setsCount,
    String? registrationLink,
    String? phone,
    String? description,
    String? accreditedEntities,
    String? whatsApp,
    String? email,
    String? hasOffer,
  }) {
    return TrainingCourse(
      isPublished: isPublished ?? this.isPublished,
      title: title ?? this.title,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      createdBy: createdBy ?? this.createdBy,
      creationDate: creationDate ?? this.creationDate,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
      limitedSets: limitedSets ?? this.limitedSets,
      isMedicalJob: isMedJob ?? this.isMedicalJob,
      courseDays: courseDays ?? this.courseDays,
      courseHours: courseHours ?? this.courseHours,
      courseBeginningDate: courseBeginningDate ?? this.courseBeginningDate,
      courseEndingDate: courseEndingDate ?? this.courseEndingDate,
      organizedBy: organizedBy ?? this.organizedBy,
      timestamp: timestamp ?? this.timestamp,
      views: views ?? this.views,
      loves: loves ?? this.loves,
      website: website ?? this.website,
      telegram: telegram ?? this.telegram,
      setsCount: setsCount ?? this.setsCount,
      registrationLink: registrationLink ?? this.registrationLink,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      accreditedEntities: accreditedEntities ?? this.accreditedEntities,
      whatsApp: whatsApp ?? this.whatsApp,
      email: email ?? this.email,
      hasOffer: hasOffer ?? this.hasOffer,
    );
  }
}
