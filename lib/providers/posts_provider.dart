import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget_example/models/post.dart';
import 'package:flutter_unity_widget_example/providers/firestore_provider.dart';
import 'package:flutter_unity_widget_example/providers/talkroom_provider.dart';

import '../allConstants/all_Constants.dart';

///postReferenceProviderが提供する
///ReferenceにあるPostを取得するプロバイダー
final postsProvider = StreamProvider.family((ref, String roomId) {
  final postsReference = ref.watch(postsReferenceProvider);
  return postsReference
      .where('roomId', isEqualTo: roomId)
      .orderBy('createdAt')
      .snapshots();
});

///現在のtalkroom直下のpostのReferenceを取得するプロバイダー
final postsReferenceProvider = Provider<CollectionReference<Post>>((ref) {
  final talkroomReference = ref.watch(talkroomReferenceProvider).value;

  ///talkroomReferenceが取得中のときは、空のコレクションを渡す。
  if (talkroomReference == null) {
    final firestore = ref.read(firestoreProvider);
    return firestore.collection('null').withConverter<Post>(
          fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
          toFirestore: ((value, _) => value.toJson()),
        );
  }

  return talkroomReference.collection(Consts.posts).withConverter<Post>(
        fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
        toFirestore: ((value, _) => value.toJson()),
      );
});
