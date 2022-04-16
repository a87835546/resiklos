import 'package:flutter/material.dart';
import 'package:resiklos/utils/constants.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -5),
      child: Container(
        margin: const EdgeInsets.only(left: 6, right: 6, bottom: 1),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1.0, color: ResiklosColors.warningDark),
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 8,
            color: ResiklosColors.warningDark,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          softWrap: false,
        ),
      ),
    );
  }
}
