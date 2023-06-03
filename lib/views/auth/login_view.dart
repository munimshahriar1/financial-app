import 'package:flutter/material.dart';

class LoginModal extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;

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
              const SizedBox(
                  height: 20), // Adjust the height here
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    isMorning
                        ? "Good Morning"
                        : "Good Evening",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
              ElevatedButton(
                onPressed: onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  minimumSize:
                      const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
