import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  Room({
    required this.roomname,
    required this.roomId,
    required this.reference,
  });

  Room copyWith({
    String? roomname,
    String? roomId,
    DocumentReference? reference,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      roomname: roomname ?? this.roomname,
      reference: reference ?? this.reference,
    );
  }

  factory Room.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!; // data() の中には Map 型のデータが入っています。
    return Room(
      roomId: map['roomId'],
      roomname: map['roomname'],
      reference:
          snapshot.reference, // 注意。reference は map ではなく snapshot に入っています。
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'roomname': roomname,
      'roomId': roomId,
      // 'reference': reference, reference は field に含めなくてよい
      // field に含めなくても DocumentSnapshot に reference が存在するため
    };
  }

  final String roomname;

  final String roomId;

  final DocumentReference reference;
}
