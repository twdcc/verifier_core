import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static Widget detailedInfoText(
      String chTitle, String enTitle, String info, BuildContext context) {
    double fontsize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chTitle,
            style: TextStyle(
              fontSize: fontsize * 0.04,
              color: Colors.black54,
            ),
          ),
          Text(
            enTitle,
            style: TextStyle(
              fontSize: fontsize * 0.03,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            child: Text(
              info,
              style: TextStyle(
                fontSize: fontsize * 0.054,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String dccFormattedDateTime(String? datetimeString,
      {bool withTime = false, bool withTimeZone = false}) {
    final dt = DateTime.tryParse(datetimeString ?? '');
    if (dt != null) {
      String formatter = 'dd/MM/yyyy';
      if (withTime) {
        formatter += ' HH:mm:ss';
      }
      String result =
          DateFormat(formatter).format(withTimeZone ? dt.toLocal() : dt);
      if (withTimeZone) {
        result +=
            "+${DateTime.now().timeZoneOffset.inHours.toString().padLeft(2, '0')}:${(DateTime.now().timeZoneOffset.inMinutes - (DateTime.now().timeZoneOffset.inHours * 60)).toString().padLeft(2, '0')}" +
                "(UTC)";
      }
      return result;
    }
    return '';
  }
}
