import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreenRoomBox extends StatelessWidget {
  const GreenRoomBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 10),
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 62, 213, 152),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 25,
                left: 20,
                child: Text('行きたいところ\nの部屋',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ))),
            Positioned(
                left: 30,
                top: 90,
                width: 100,
                child: Image.asset('images/roomgrid/GreenBoxImage.png')),
          ],
        ),
      ),
    );
  }
}
