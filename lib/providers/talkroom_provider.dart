import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget_example/models/post.dart';
import 'package:flutter_unity_widget_example/models/room.dart';
import 'package:flutter_unity_widget_example/providers/auth_provider.dart';

import '../allConstants/all_Constants.dart';
import 'firestore_provider.dart';

///ユーザーはログインしてるし、TalkroomIdはなかったら作る。//talkroomidはnullの場合がある。
final talkroomIdProvider = FutureProvider<String>((ref) async {
  final firestore = ref.read(firestoreProvider);
  final String? uid = ref.read(uidProvider);
  if (uid == null) {
    throw Exception('ログインしていません。');
  }

  final userDocRef = firestore.collection(Consts.users).doc(uid);
  final userDocumentSnapshot = await userDocRef.get();
  String getTalkroomId(talkroomId) {
    if (talkroomId != null) {
      return userDocumentSnapshot.get(Consts.talkroomId)!;
    } else {
      userDocRef.update({Consts.talkroomId: uid});
      return userDocumentSnapshot.get(Consts.talkroomId)!;
    }
  }

  if (userDocumentSnapshot.exists) {
    final String? talkroomId = userDocumentSnapshot.get(Consts.talkroomId);
    return getTalkroomId(talkroomId);
  }

  ///ユーザーDocがないときはDocを作成後talkroomIdを取得。
  else {
    await firestore
        .collection(Consts.users)
        .doc(uid)
        .set({Consts.talkroomId: uid});
    final userReDocumentSnapshot =
        await firestore.collection(Consts.users).doc(uid).get();
    final String talkroomId = userReDocumentSnapshot.get(Consts.talkroomId);
    return getTalkroomId(talkroomId);
  }
});

final talkroomReferenceProvider = FutureProvider((ref) async {
  final firestore = ref.read(firestoreProvider);
  final uid = ref.watch(uidProvider);
  final String? talkroomId = ref.watch(talkroomIdProvider).value;
  final talkDocroomRef = firestore.collection(Consts.talkrooms).doc(talkroomId);
  final talkroomDoc = await talkDocroomRef.get();
  if (talkroomId == null) {
    return null;
  }

  ///talkroomDocが存在しないときに、talkroomを生成。
  void talkroomsetter() {
    talkDocroomRef.set({
      'users': [uid]
    });
    talkDocroomRef.collection(Consts.posts).doc();
    final initpost = Post(
        text: '',
        roomId: '',
        createdAt: Timestamp.now(),
        posterName: '',
        posterImageUrl: '',
        posterId: '',
        stamps: '',
        reference: talkDocroomRef.collection(Consts.posts).doc('init'));
    final initPostDoc = talkDocroomRef.collection(Consts.posts).doc('init');
    initPostDoc.set(initpost.toJson());

    final initroom = Room(
        roomname: 'General',
        roomId: 'init',
        reference: talkDocroomRef.collection(Consts.rooms).doc('init'));
    final initRoomDoc = talkDocroomRef.collection(Consts.rooms).doc('init');

    initRoomDoc.set(initroom.toJson());
  }

  if (talkroomDoc.exists) {
    return talkDocroomRef;
  } else {
    print('tester');
    talkroomsetter();
    final retalkDocroomRef =
        await firestore.collection(Consts.talkrooms).doc(talkroomId);
    return retalkDocroomRef;
  }
});
