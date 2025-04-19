import 'package:flutter/cupertino.dart';

import 'color.dart';

TextSpan parseMarkdown(String input) {
  final List<InlineSpan> children = [];

  final boldRegex = RegExp(r'\*\*(.*?)\*\*');
  final italicRegex = RegExp(r'\*(.*?)\*');

  String temp = input;

  while (temp.isNotEmpty) {
    final boldMatch = boldRegex.firstMatch(temp);
    final italicMatch = italicRegex.firstMatch(temp);

    if (boldMatch != null &&
        (italicMatch == null || boldMatch.start < italicMatch.start)) {
      if (boldMatch.start > 0) {
        children.add(TextSpan(text: temp.substring(0, boldMatch.start)));
      }
      children.add(
        TextSpan(
          text: boldMatch.group(1),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      temp = temp.substring(boldMatch.end);
    } else if (italicMatch != null) {
      if (italicMatch.start > 0) {
        children.add(TextSpan(text: temp.substring(0, italicMatch.start)));
      }
      children.add(
        TextSpan(
          text: italicMatch.group(1),
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      );
      temp = temp.substring(italicMatch.end);
    } else {
      children.add(TextSpan(text: temp));
      break;
    }
  }

  return TextSpan(style: TextStyle(color: AppThemeHelper.textFieldText, fontSize: 22), children: children);
}
