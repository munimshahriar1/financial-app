import 'package:flutter/material.dart';
import './login_view.dart';
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
            child: Opacity(
              opacity: 0.95,
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
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Text(
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
      isDismissible: false,
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
}
