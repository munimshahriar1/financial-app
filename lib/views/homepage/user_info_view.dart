import 'package:flutter/material.dart';
import 'package:s8_finapp/views/widgets/expanded_button.dart';
import 'package:s8_finapp/views/widgets/user_info_card.dart';
import '../auth/authentication.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  void logOut() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => LoginPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(14, 10, 10, 0),
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
                  username: 'JohnDoe',
                  phoneNumber: '123-456-7890',
                  password: 'secretpassword',
                ),
                SizedBox(height: 10),
                ExpandedButton(
                  onPressed: logOut,
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
