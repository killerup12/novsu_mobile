import 'package:novsu_mobile/domain/models/journal.dart';
import 'package:novsu_mobile/features/utils/hex_color.dart';
import 'package:flutter/material.dart';

class SubjectWidget extends StatelessWidget {
  final Journal journalItem;
  final Function onTap;

  const SubjectWidget({
    Key? key,
    required this.journalItem,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: HexColor('#A8D793'), width: 4), //TODO add to theme
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(journalItem.subject),
            Text(journalItem.grade.toString())
          ],
        ),
      ),
    );
  }
}
