import "package:firebase_auth/firebase_auth.dart";

typedef VerificationIdCallback = Future Function(
    String verificationId);
typedef VerificationFailedCallback = void Function(
    String error);

typedef VerificationCompletedCallback = void Function();

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInPhoneNumberAndOtp({
    required String phoneNumber,
    required VerificationIdCallback
        onVerificationIdReceived,
    required VerificationFailedCallback
        onVerificationFailed,
    required VerificationCompletedCallback
        onVerificationCompleted,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (e) {
          onVerificationCompleted();
        },
        verificationFailed: (e) {
          // Sending error message to parent
          onVerificationFailed(e.toString());
        },
        codeSent:
            (String verificationId, int? token) async {
          final otpCode = await onVerificationIdReceived(
              verificationId);

          print("Child");
          print("Received OTP Code");
          print(otpCode);

          // Go to the next stage only if OTP available
          if (otpCode != '') {
            final credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otpCode,
            );
            try {
              // Sign the user in (or link) with the credential
              await _firebaseAuth
                  .signInWithCredential(credential);
            } on FirebaseAuthException catch (e) {
              print(e);
            }
          }
        },
        codeAutoRetrievalTimeout: (e) {
          print(e);
        });
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
