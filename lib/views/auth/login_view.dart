// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s8_finapp/auth/auth.dart';
import 'package:s8_finapp/views/widgets/buttons/expanded_button.dart';

class LoginModal extends StatefulWidget {
  final TextEditingController loginIdController;
  final TextEditingController loginPasswordController;
  final VoidCallback openRegisterModal;

  const LoginModal({
    Key? key,
    required this.loginIdController,
    required this.loginPasswordController,
    required this.openRegisterModal,
  }) : super(key: key);

  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  String? errorMessage = '';

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: widget.loginIdController.text,
          password: widget.loginPasswordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

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
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextButton(
                            onPressed:
                                widget.openRegisterModal,
                            child: const Text(
                              "Register",
                              style: TextStyle(
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
                  controller: widget.loginIdController,
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
                  controller:
                      widget.loginPasswordController,
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
                  onPressed: signInWithEmailAndPassword,
                  buttonText: "Login",
                  isDarkTheme: false,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
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
