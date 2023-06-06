import 'package:flutter/material.dart';
import 'package:s8_finapp/auth/auth.dart';
import './login_view.dart';
import '../homepage/homepage.dart';
import 'package:s8_finapp/views/auth/register_view.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationPageState createState() =>
      _AuthenticationPageState();
}

class _AuthenticationPageState
    extends State<AuthenticationPage> {
  final _loginIdController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool isLogin = true;
  double modalHeight = 420;

  void openRegisterModal() {
    setState(() {
      isLogin = false;
      modalHeight = 490;
    });
  }

  void openLoginModal() {
    setState(() {
      isLogin = true;
      modalHeight = 420;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return Scaffold(
            body: Stack(
              children: [
                Opacity(
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
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, 250, 0, 0),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: modalHeight,
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: isLogin
                        ? LoginModal(
                            loginIdController:
                                _loginIdController,
                            loginPasswordController:
                                _loginPasswordController,
                            openRegisterModal:
                                openRegisterModal,
                          )
                        : RegisterModal(
                            usernameController:
                                _usernameController,
                            passwordController:
                                _passwordController,
                            phoneNumberController:
                                _phoneNumberController,
                            openLoginModal: openLoginModal,
                          ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
