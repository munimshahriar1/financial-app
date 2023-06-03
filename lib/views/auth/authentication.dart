import 'package:flutter/material.dart';
import './login_view.dart';
import './register_view.dart';
import '../homepage/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLoginButtonPressed() {
    // TODO: Implement login logic
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const HomePage()));
  }

  void _handleForgotPasswordButtonPressed() {
    // TODO: Implement forgot password logic
  }

  // Open the login modal by default
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLoginModal(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _showLoginModal(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/login_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showRegisterModal(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkResponse(
                    onTap: () {
                      _showRegisterModal(context);
                    },
                    splashColor:
                        Colors.white.withOpacity(0.5),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showLoginModal(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Pulse9 Digital Financing",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLoginModal(BuildContext context) {
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
          usernameController: _usernameController,
          passwordController: _passwordController,
          onLoginPressed: _handleLoginButtonPressed,
          onForgotPasswordPressed:
              _handleForgotPasswordButtonPressed,
        );
      },
    );
  }

  void _showRegisterModal(BuildContext context) {
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
        return RegisterModal(
          usernameController: _usernameController,
          phoneNumberController: TextEditingController(),
          passwordController: _passwordController,
          confirmPasswordController:
              TextEditingController(),
          onRegisterPressed: () {
            // TODO: Implement register logic
          },
        );
      },
    );
  }
}
