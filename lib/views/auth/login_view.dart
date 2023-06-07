import 'package:flutter/material.dart';
import 'package:s8_finapp/auth/auth.dart';
import 'package:s8_finapp/views/widgets/buttons/expanded_button.dart';

class LoginModal extends StatefulWidget {
  final TextEditingController loginIdController;
  final TextEditingController loginPasswordController;
  final TextEditingController loginPhonenumberController;
  final TextEditingController loginOtpController;
  final VoidCallback openRegisterModal;
  final Function(bool, dynamic) updateIsLoginLoading;
  bool isLoginLoading;

  LoginModal({
    Key? key,
    required this.loginIdController,
    required this.loginPasswordController,
    required this.loginPhonenumberController,
    required this.loginOtpController,
    required this.openRegisterModal,
    required this.isLoginLoading,
    required this.updateIsLoginLoading,
  }) : super(key: key);

  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  String selectedCountryCode = "+852";
  bool isEmailAuthentication = true;
  String verificationId = '';
  bool isOtpReceived = false;

  void toggleAuthentication() {
    setState(() {
      isEmailAuthentication = !isEmailAuthentication;
    });
  }

  String errorMessage = '';

  Future<void> signInWithEmailAndPassword() async {
    widget.updateIsLoginLoading(true, errorMessage);

    try {
      await Auth().signInWithEmailAndPassword(
        email: widget.loginIdController.text,
        password: widget.loginPasswordController.text,
      );
      widget.loginIdController.clear();
      widget.loginPasswordController.clear();
    } catch (e) {
      final regex = RegExp(r'\]\s(.*)$');
      final match = regex.firstMatch(e.toString());
      if (match != null) {
        errorMessage = match.group(1) ?? '';
      }
      widget.updateIsLoginLoading(true, errorMessage);
    } finally {
      widget.updateIsLoginLoading(false, errorMessage);
    }
  }

  Future<void> signWithPhoneNumberAndOtp() async {
    widget.updateIsLoginLoading(true, errorMessage);

    try {
      final phoneNumber = selectedCountryCode +
          widget.loginPhonenumberController.text;
      await Auth().signInPhoneNumberAndOtp(
        onVerificationIdReceived: (id) async {
          verificationId = id;
          widget.updateIsLoginLoading(true, errorMessage);

          // Documentation
          // Receiving verificationId from child and sending the OTP in return
          if (verificationId != '') {
            setState(() {
              isOtpReceived = true;
            });
          }

          final otpCode = widget.loginOtpController.text;
          // final otpCode = "000000";
          return otpCode;
        },
        onVerificationFailed: (error) {
          widget.updateIsLoginLoading(true, error);
        },
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      final regex = RegExp(r'\]\s(.*)$');
      final match = regex.firstMatch(e.toString());
      if (match != null) {
        errorMessage = match.group(1) ?? '';
        widget.updateIsLoginLoading(true, errorMessage);
      }
    } finally {
      widget.updateIsLoginLoading(false, errorMessage);
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
                      Row(
                        children: [
                          const Text(
                            "Login with",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextButton(
                            onPressed: toggleAuthentication,
                            child: Text(
                              isEmailAuthentication
                                  ? "Phonenumber"
                                  : "Email",
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
              isEmailAuthentication
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 20),
                          child: TextField(
                            controller:
                                widget.loginIdController,
                            style: const TextStyle(
                                color: Colors.white),
                            decoration:
                                const InputDecoration(
                              hintText: "Username/ Email",
                              hintStyle: TextStyle(
                                  color: Colors.white54),
                              focusedBorder:
                                  UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 20),
                          child: TextField(
                            controller: widget
                                .loginPasswordController,
                            obscureText: true,
                            style: const TextStyle(
                                color: Colors.white),
                            decoration:
                                const InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.white54),
                              focusedBorder:
                                  UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding:
                              const EdgeInsets.all(14.0),
                          child: ExpandedButton(
                            onPressed:
                                signInWithEmailAndPassword,
                            buttonText: "Login",
                            isDarkTheme: false,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 20),
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                  value:
                                      selectedCountryCode,
                                  onChanged:
                                      (String? newValue) {
                                    setState(() {
                                      selectedCountryCode =
                                          newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '+852',
                                    '+1',
                                    '+880',
                                  ] // Replace with your list of country codes
                                      .map<
                                          DropdownMenuItem<
                                              String>>(
                                    (String value) {
                                      return DropdownMenuItem<
                                          String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors
                                                  .grey),
                                        ),
                                      );
                                    },
                                  ).toList()),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: widget
                                      .loginPhonenumberController,
                                  style: const TextStyle(
                                      color: Colors.white),
                                  decoration:
                                      const InputDecoration(
                                    hintText:
                                        "Phone Number",
                                    hintStyle: TextStyle(
                                        color:
                                            Colors.white54),
                                    focusedBorder:
                                        UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(
                                              color: Colors
                                                  .white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (isOtpReceived)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white),
                                borderRadius:
                                    BorderRadius.circular(
                                        5),
                              ),
                              child: TextField(
                                controller: widget
                                    .loginOtpController,
                                style: const TextStyle(
                                    color: Colors.white),
                                decoration:
                                    const InputDecoration(
                                  hintText:
                                      "Enter 6 digit code",
                                  hintStyle: TextStyle(
                                      color:
                                          Colors.white54),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.all(10),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.all(14.0),
                          child: ExpandedButton(
                            onPressed:
                                signWithPhoneNumberAndOtp,
                            buttonText: !isOtpReceived
                                ? "Send Code"
                                : "Submit",
                            isDarkTheme: false,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
