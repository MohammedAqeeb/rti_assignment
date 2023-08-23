import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.title,
    this.color = lightGrey,
  }) : super(key: key);

  final String? title;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title ?? 'NA',
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: const Color.fromRGBO(29, 161, 242, 1),
        ),
      ),
    );
  }
}
