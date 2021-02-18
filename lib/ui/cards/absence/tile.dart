import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:filcnaplo/data/context/app.dart';
import 'package:filcnaplo/data/models/absence.dart';
import 'package:filcnaplo/generated/i18n.dart';
import 'package:filcnaplo/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:filcnaplo/ui/pages/absences/absence/view.dart';
import 'package:intl/intl.dart';

class AbsenceTile extends StatelessWidget {
  final Absence absence;

  AbsenceTile(this.absence);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 46.0,
          height: 46.0,
          alignment: Alignment.center,
          child: Icon(
            absence.state == "Igazolando"
                ? FeatherIcons.slash
                : FeatherIcons.check,
            color: absence.state == "Igazolando"
                ? Colors.yellow[600]
                : Colors.green,
            size: 30,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    absence.type.description,
                  ),
                  Text(" • " + absence.mode.description,
                      style: TextStyle(
                          //Copied directly from ListTile source code, same as subtitle
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize,
                          color: Theme.of(context).textTheme.caption.color),
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(formatDate(context, absence.submitDate)),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                absence.lessonIndex != null
                    ? Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          absence.lessonIndex.toString() + ".",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.caption.color,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
                Text(
                  capital(absence.subject.name ?? I18n.of(context).unknown),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Text(capital(DateFormat("EEEE", app.settings.locale.toString())
                    .format(absence.date)) +
                (absence.date
                        .isAfter(DateTime.now().subtract(Duration(days: 6)))
                    ? ""
                    : (" " + formatDate(context, absence.date)))),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) => AbsenceView(absence),
        );
      },
    );
  }
}
