import 'package:flutter/material.dart';
import 'package:s8_finapp/views/auth/login_view.dart';
import 'package:s8_finapp/views/widgets/buttons/expanded_button.dart';

class RegisterModal extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegisterPressed;

  void _showLoginModal(BuildContext context) {
    Navigator.of(context).pop(); // Close the RegisterModal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return LoginModal(
          usernameController: usernameController,
          passwordController: passwordController,
          onLoginPressed: () {
            // TODO: Implement login logic
          },
          onForgotPasswordPressed: () {
            // TODO: Implement forgot password logic
          },
        );
      },
    );
  }

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
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            _showLoginModal(context),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            decoration:
                                TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ExpandedButton(
              onPressed: onRegisterPressed,
              buttonText: "Register",
              isDarkTheme: false,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  String _getPasswordStrengthText(String password) {
    // Password strength logic here...
    // Return appropriate strength text based on the password
    // You can reuse the existing _getPasswordStrengthText() implementation from your code
    // ...
    return "";
  }
}
