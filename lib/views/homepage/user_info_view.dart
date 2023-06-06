import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s8_finapp/auth/auth.dart';
import 'package:s8_finapp/views/widgets/buttons/expanded_button.dart';
import 'package:s8_finapp/views/widgets/cards/user_info_card.dart';

class UserInfo extends StatelessWidget {
  final BuildContext context;
  UserInfo({Key? key, required this.context})
      : super(key: key);

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(14, 14, 10, 0),
            child: Row(
              children: const [
                Text(
                  'User Info',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                UserInfoCard(
                  username: user?.email ?? '',
                  phoneNumber: user?.phoneNumber ?? '',
                  password: '**************',
                ),
                SizedBox(height: 10),
                ExpandedButton(
                  onPressed: signOut,
                  buttonText: "Log out",
                  isDarkTheme: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
