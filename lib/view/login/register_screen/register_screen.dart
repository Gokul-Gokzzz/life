import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lifelinekerala/view/login/register_screen/widget/register_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final url = Uri.parse(
                  'https://lifelinekeralatrust.com/member/auth/register');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
                log('url is:${url}');
              }
            },
            child: Text('open Url')),
      ),
    );
  }
}
