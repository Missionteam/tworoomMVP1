import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room {
  Room({
    required this.roomname,
    required this.roomId,
    required this.reference,
    this.roomIndex = 0,
    this.color = Colors.white,
    this.image = '',
  });

  Room copyWith({
    String? roomname,
    String? roomId,
    DocumentReference? reference,
    int? roomIndex,
    Color? color,
    String? image,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      roomname: roomname ?? this.roomname,
      reference: reference ?? this.reference,
      roomIndex: roomIndex ?? this.roomIndex,
      color: color ?? this.color,
      image: image ?? this.image,
    );
  }

  factory Room.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!; // data() の中には Map 型のデータが入っています。
    return Room(
      roomId: map['roomId'],
      roomname: map['roomname'],
      roomIndex: map['roomIndex'],
      color: map['color'],
      image: map['image'],
      reference:
          snapshot.reference, // 注意。reference は map ではなく snapshot に入っています。
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'roomname': roomname,
      'roomId': roomId,
      'roomIndex': roomIndex,
      'color': color,
      'image': image
      // 'reference': reference, reference は field に含めなくてよい
      // field に含めなくても DocumentSnapshot に reference が存在するため
    };
  }

  final String roomname;

  final String roomId;

  final DocumentReference reference;

  final int roomIndex;
  final Color color;
  final String image;
}
