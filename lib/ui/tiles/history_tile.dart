import 'package:estok_app/app/shared/constants.dart';
import 'package:estok_app/entities/history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTile extends StatelessWidget {

  History history;
  HistoryTile(this.history);

  @override
  Widget build(BuildContext context) {

    final DateTime dateTime = history.date;
    final DateFormat dateFormatter = DateFormat(Constants.DATE_FORMAT_STRING);
    final DateFormat timeFormatter = DateFormat("HH:mm");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 9, left: 26, right: 16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${history.operationType} ${history.objectName}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF555353),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${history.entityType}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF949191),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "${dateFormatter.format(dateTime)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${timeFormatter.format(dateTime)}",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
