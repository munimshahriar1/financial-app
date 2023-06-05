import 'package:flutter/material.dart';
import 'package:s8_finapp/views/auth/register_view.dart';
import 'package:s8_finapp/views/widgets/buttons/expanded_button.dart';

class LoginModal extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;

  void _showRegisterModal(BuildContext context) {
    Navigator.of(context).pop(); // Close the LoginModal
    showModalBottomSheet(
      isDismissible: false,
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
        return RegisterModal(
          usernameController: usernameController,
          phoneNumberController: TextEditingController(),
          passwordController: passwordController,
          confirmPasswordController:
              TextEditingController(),
          onRegisterPressed: () {
            // TODO: Implement register logic
          },
        );
      },
    );
  }

  const LoginModal({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final isMorning = currentTime.hour < 12;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.9),
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
                      Text(
                        isMorning
                            ? "Good Morning"
                            : "Good Evening",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                _showRegisterModal(context),
                            child: Text(
                              "Register",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.normal,
                                decoration: TextDecoration
                                    .underline,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 20),
                child: TextField(
                  controller: usernameController,
                  style:
                      const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Username/Phone Number",
                    hintStyle:
                        TextStyle(color: Colors.white54),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style:
                      const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Password",
                    hintStyle:
                        TextStyle(color: Colors.white54),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: ExpandedButton(
                    onPressed: onLoginPressed,
                    buttonText: "Login",
                    isDarkTheme: false),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: onForgotPasswordPressed,
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
