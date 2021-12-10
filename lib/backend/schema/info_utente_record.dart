import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'info_utente_record.g.dart';

abstract class InfoUtenteRecord
    implements Built<InfoUtenteRecord, InfoUtenteRecordBuilder> {
  static Serializer<InfoUtenteRecord> get serializer =>
      _$infoUtenteRecordSerializer;

  @nullable
  String get nome;

  @nullable
  String get cognome;

  @nullable
  String get azienda;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(InfoUtenteRecordBuilder builder) => builder
    ..nome = ''
    ..cognome = ''
    ..azienda = ''
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('info_utente');

  static Stream<InfoUtenteRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  InfoUtenteRecord._();
  factory InfoUtenteRecord([void Function(InfoUtenteRecordBuilder) updates]) =
      _$InfoUtenteRecord;

  static InfoUtenteRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createInfoUtenteRecordData({
  String nome,
  String cognome,
  String azienda,
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
}) =>
    serializers.toFirestore(
        InfoUtenteRecord.serializer,
        InfoUtenteRecord((i) => i
          ..nome = nome
          ..cognome = cognome
          ..azienda = azienda
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber));
