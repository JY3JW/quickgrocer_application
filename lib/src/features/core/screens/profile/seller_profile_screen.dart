import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quickgrocer_application/src/utils/theme/theme.dart';

class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var iconColor =
        Get.isDarkMode ? AppColors.subPistachioColor : AppColors.mainPineColor;
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final emailAddress = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          profile,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(AppTheme.lightTheme)
                    : Get.changeTheme(AppTheme.darkTheme);
              },
              icon: Icon(
                Get.isDarkMode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: iconColorWithoutBackground,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage(profileImage))),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                  child: Column(
                children: [
                  Text('Store Owner',
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text(emailAddress!,
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: Text('Logout'),
                              content:
                                  Text('Confirm to log out of your account?'),
                              actions: [
                                ElevatedButton(
                                  child: Text('NO'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                ElevatedButton(
                                  child: Text('YES'),
                                  onPressed: () => AuthenticationRepository
                                      .instance
                                      .logout(),
                                ),
                              ]));
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: iconColor.withOpacity(0.3),
                  ),
                  child: Icon(LineAwesomeIcons.alternate_sign_out,
                      color: iconColor),
                ),
                title: Text(logout,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}