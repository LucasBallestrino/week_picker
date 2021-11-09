import 'package:flutter/material.dart';

class BodyWeekPickerCard extends StatelessWidget {
  final String? titleAsString;
  final Text? titleAsWidget;

  final String? descAsString;
  final Text? descAsWidget;

  final Widget? leading;
  final Widget? trailing;

  const BodyWeekPickerCard(
      {this.titleAsString,
      this.descAsString,
      this.leading,
      this.trailing,
      this.titleAsWidget,
      this.descAsWidget});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: leading,
        title: titleAsWidget ??
            Text(titleAsString ?? "Default title, set a custom one!!"),
        subtitle: descAsWidget ??
            Text(descAsString ?? "Default desc set a custom one!!"),
        trailing: trailing,
        isThreeLine: true,
      ),
    );
  }
}
