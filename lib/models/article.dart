import 'package:cloud_firestore/cloud_firestore.dart';

class MixModel {
  bool isPublished;
  String title;
  String mediaUrl;
  String createdBy;
  String creationDate;

  String whatsApp;
  String? timestamp;

  MixModel({
    required this.isPublished,
    required this.title,
    required this.mediaUrl,
    required this.createdBy,
    required this.creationDate,
   required this.whatsApp,
    this.timestamp,
  });

  factory MixModel.fromFireStore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return MixModel(
      isPublished: d['isPublished'],
      title: d['title'],
      mediaUrl: d['media_url'],
      createdBy: d['cre_by'],
      creationDate: d['cre_date'],
      whatsApp: d['w_app'],
      timestamp: d['timestamp'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'isPublished': this.isPublished,
      'media_url': this.mediaUrl,
      'title': this.title,
      'cre_date': this.creationDate,
      'timestamp': this.timestamp,
      'cre_by': this.createdBy,
      'w_app': this.whatsApp,
    };
  }

  MixModel copyWith({
    bool? isPublished,
    String? title,
    String? mediaUrl,
    String? createdBy,
    String? creationDate,
    String? timestamp,
    String? whatsApp,
  }) {
    return MixModel(
      isPublished: isPublished ?? this.isPublished,
      title: title ?? this.title,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      createdBy: createdBy ?? this.createdBy,
      creationDate: creationDate ?? this.creationDate,
      timestamp: timestamp ?? this.timestamp,
      whatsApp: whatsApp ?? this.whatsApp,
    );
  }
}
