import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/login/widgets/login_footer_widget.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/login/widgets/login_form_widget.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/login/widgets/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeaderWidget(size: size),
                const LoginForm(),
                const LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}