import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String username;
  final String phoneNumber;
  final String password;

  const UserInfoCard({
    required this.username,
    required this.phoneNumber,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Expanded(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text(
                  'Username:  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Text(
                  'Phone Number:  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  phoneNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Text(
                  'Password:  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  password,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
