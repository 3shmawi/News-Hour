import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeReplacement {
  bool isPublished;

  String title;
  String mediaUrl;
  String createdBy;
  String creationDate;
  String availableFrom;
  String availableTo;
  String currentPosition;
  String neededPosition;
  String searchFor;
  String jobType;
  String jobCity;
  String jobAddress;
  String organizationName;

  String? description;
  String? phone;
  String? website;
  String? whatsApp;
  String? telegram;
  String? email;

  String? timestamp;

  EmployeeReplacement({
    required this.isPublished,
    required this.title,
    required this.mediaUrl,
    required this.createdBy,
    required this.creationDate,
    required this.availableFrom,
    required this.availableTo,
    required this.currentPosition,
    required this.neededPosition,
    required this.searchFor,
    required this.jobType,
    required this.jobCity,
    required this.jobAddress,
    required this.organizationName,
    this.description,
    this.website,
    this.whatsApp,
    this.telegram,
    this.phone,
    this.email,
    this.timestamp,
  });

  factory EmployeeReplacement.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return EmployeeReplacement(
      isPublished: d['isPublished'],
      title: d['title'],
      mediaUrl: d['media_url'],
      createdBy: d['cre_by'],
      creationDate: d['cre_date'],
      availableFrom: d['av_from'],
      availableTo: d['av_to'],
      currentPosition: d['c_p'],
      neededPosition: d['n_p'],
      jobAddress: d['j_ad'],
      jobCity: d['j_c'],
      jobType: d['j_t'],
      organizationName: d['o_na'],
      searchFor: d['s_for'],
      description: d['desc'],
      phone: d['phone'],
      telegram: d['telegram'],
      website: d['website'],
      whatsApp: d['w_app'],
      email: d['email'],
      timestamp: d['timestamp'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'isPublished': this.isPublished,
      'media_url': this.mediaUrl,
      'title': this.title,
      'cre_by': this.createdBy,
      'cre_date': this.creationDate,
      'desc': this.description,
      'o_na': this.organizationName,
      'c_p': this.currentPosition,
      'n_p': this.neededPosition,
      'j_ad': this.jobAddress,
      'j_t': this.jobType,
      'j_c': this.jobCity,
      's_for': this.searchFor,
      'av_from': this.availableFrom,
      'av_to': this.availableTo,
      'phone': this.phone,
      'telegram': this.telegram,
      'website': this.website,
      'w_app': this.whatsApp,
      'email': this.email,
      'timestamp': this.timestamp,
    };
  }

  EmployeeReplacement copyWith({
    bool? isPublished,
    String? title,
    String? mediaUrl,
    String? creationDate,
    String? createdBy,
    String? availableFrom,
    String? availableTo,
    String? timestamp,
    String? website,
    String? telegram,
    String? phone,
    String? description,
    String? whatsApp,
    String? email,
    String? currentPosition,
    String? neededPosition,
    String? searchFor,
    String? jobType,
    String? jobCity,
    String? jobAddress,
    String? organizationName,
  }) {
    return EmployeeReplacement(
      isPublished: isPublished ?? this.isPublished,
      title: title ?? this.title,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      creationDate: creationDate ?? this.creationDate,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
      jobCity: jobCity ?? this.jobCity,
      jobAddress: jobAddress ?? this.jobAddress,
      jobType: jobType ?? this.jobType,
      organizationName: organizationName ?? this.organizationName,
      currentPosition: currentPosition ?? this.currentPosition,
      neededPosition: neededPosition ?? this.neededPosition,
      timestamp: timestamp ?? this.timestamp,
      website: website ?? this.website,
      telegram: telegram ?? this.telegram,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      whatsApp: whatsApp ?? this.whatsApp,
      email: email ?? this.email,
      searchFor: searchFor ?? this.searchFor,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
