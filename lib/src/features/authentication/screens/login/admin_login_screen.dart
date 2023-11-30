import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/common_widgets/form/form_header_widget.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/login/widgets/adminlogin_footer_widget.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/login/widgets/adminlogin_form_widget.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                FormHeaderWidget(
                  image: welcomeScreenImage,
                  title: adminLogin,
                  subTitle: loginSubtitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                AdminLoginForm(),
                AdminLoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
