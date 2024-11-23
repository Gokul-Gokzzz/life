import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String imagePath;
  final String text;
  final void Function()? onTap;
  final Widget? trailing;
  const MyListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Image.asset(imagePath, width: 20, height: 20),
        onTap: onTap,
        trailing: trailing,
        title: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
