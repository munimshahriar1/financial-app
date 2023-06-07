import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s8_finapp/auth/auth.dart';
import 'package:s8_finapp/views/widgets/buttons/expanded_button.dart';

class RegisterModal extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final VoidCallback openLoginModal;
  final Function(bool, dynamic) updateIsRegisterLoading;
  bool isRegisterLoading;

  RegisterModal(
      {Key? key,
      required this.usernameController,
      required this.phoneNumberController,
      required this.passwordController,
      required this.openLoginModal,
      required this.isRegisterLoading,
      required this.updateIsRegisterLoading})
      : super(key: key);

  @override
  _RegisterModalState createState() =>
      _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  String? errorMessage = '';

  Future<void> createUserWithEmailAndPassword() async {
    widget.updateIsRegisterLoading(true, errorMessage);
    try {
      await Auth().createUserWithEmailAndPassword(
        email: widget.usernameController.text,
        password: widget.passwordController.text,
      );

      widget.usernameController.clear();
      widget.passwordController.clear();
    } on FirebaseAuthException catch (e) {
      final regex = RegExp(r'\]\s(.*)$');
      final match = regex.firstMatch(e.toString());
      if (match != null) {
        errorMessage = match.group(1) ??
            ''; // Assign the value to the class-level errorMessage
      }
      widget.updateIsRegisterLoading(true, errorMessage);
    } finally {
      widget.updateIsRegisterLoading(false, errorMessage);
    }
  }

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
                        onPressed: widget.openLoginModal,
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
              controller: widget.usernameController,
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
              controller: widget.phoneNumberController,
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
              controller: widget.passwordController,
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
              controller: TextEditingController(),
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
                        widget.passwordController.text),
                    style: const TextStyle(
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ExpandedButton(
              onPressed: createUserWithEmailAndPassword,
              buttonText: "Register",
              isDarkTheme: false,
            ),
          ),
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
