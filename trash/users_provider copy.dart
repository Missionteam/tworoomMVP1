import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<DocumentReference<Map<String, dynamic>>>
    currentUserDocReferencs() async {
  final uid = await FirebaseAuth.instance
      .userChanges()
      .map((event) => event?.uid)
      .toString();
  return FirebaseFirestore.instance.collection('users').doc(uid);
}

Future<String> roomId() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final userDocumentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final roomId = userDocumentSnapshot.get('roomId');
  return roomId;
}

final roomIdProvider = FutureProvider<FutureProvider<String>>((ref) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final userDocumentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final roomId = userDocumentSnapshot.get('roomId');
  return roomId;
});
