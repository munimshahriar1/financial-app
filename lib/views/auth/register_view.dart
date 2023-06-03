import 'package:flutter/material.dart';

class RegisterModal extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegisterPressed;

  const RegisterModal({
    Key? key,
    required this.usernameController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegisterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Text(
            "User Registration",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.white54),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: phoneNumberController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                hintStyle: TextStyle(color: Colors.white54),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white54),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                hintStyle: TextStyle(color: Colors.white54),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getPasswordStrengthText(
                        passwordController.text),
                    style: const TextStyle(
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRegisterPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _getPasswordStrengthText(String password) {
    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasNumber = false;
    bool hasSpecialCharacters = false;

    for (int i = 0; i < password.length; i++) {
      String character = password[i];
      if (RegExp(r'[A-Z]').hasMatch(character)) {
        hasUppercase = true;
      } else if (RegExp(r'[a-z]').hasMatch(character)) {
        hasLowercase = true;
      } else if (RegExp(r'[0-9]').hasMatch(character)) {
        hasNumber = true;
      } else {
        hasSpecialCharacters = true;
      }
    }

    if (password.length < 8) {
      return "Password too short";
    } else if (!hasUppercase) {
      return "Password should contain at least one uppercase letter";
    } else if (!hasLowercase) {
      return "Password should contain at least one lowercase letter";
    } else if (!hasNumber) {
      return "Password should contain at least one number";
    } else if (!hasSpecialCharacters) {
      return "Password should contain at least one special character";
    } else {
      return "Strong password";
    }
  }
}
