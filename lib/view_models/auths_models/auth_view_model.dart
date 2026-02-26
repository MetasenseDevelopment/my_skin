import 'package:flutter/material.dart';
import 'package:my_skin/views/auth_screen/login/login_auth_screen.dart';
import 'package:my_skin/views/auth_screen/otp/otp_screen.dart';

enum AuthStatus { idle, loading, success, error }

class AuthProvider extends ChangeNotifier {
  // ── Auth state ────────────────────────────────────────────────────────────
  AuthStatus _status = AuthStatus.idle;
  String? _errorMessage;

  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;

  // ═══════════════════════════════════════════════════════════════════════════
  // LOGIN STATE
  // ═══════════════════════════════════════════════════════════════════════════
  String _loginEmail = '';
  String _loginPassword = '';
  bool _isLoginPasswordVisible = false;
  bool _isLoginFormActive = false;
  bool _showForgotPassword = false;
  String? _loginEmailError;
  String? _loginPasswordError;
  bool _loginHasSubmitted = false;

  String get loginEmail => _loginEmail;
  String get loginPassword => _loginPassword;
  bool get isLoginPasswordVisible => _isLoginPasswordVisible;
  bool get isLoginFormActive => _isLoginFormActive;
  bool get showForgotPassword => _showForgotPassword;
  String? get loginEmailError => _loginEmailError;
  String? get loginPasswordError => _loginPasswordError;

  bool get isLoginFormValid {
    final emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(_loginEmail) && _loginPassword.isNotEmpty;
  }

  void validateLoginEmail() {
    final emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[a-zA-Z]{2,}$');
    if (_loginEmail.isEmpty) {
      _loginEmailError = 'Email is required';
    } else if (!emailRegex.hasMatch(_loginEmail)) {
      _loginEmailError = 'Enter a valid email (e.g. name@example.com)';
    } else {
      _loginEmailError = null;
    }
    notifyListeners();
  }

  void validateLoginPassword() {
    if (_loginPassword.isEmpty) {
      _loginPasswordError = 'Password is required';
    } else {
      _loginPasswordError = null;
    }
    notifyListeners();
  }

  void updateLoginEmail(String value) {
    _loginEmail = value;
    _isLoginFormActive = true;
    if (_loginHasSubmitted) validateLoginEmail();
    notifyListeners();
  }

  void updateLoginPassword(String value) {
    _loginPassword = value;
    _isLoginFormActive = true;
    if (_loginHasSubmitted) validateLoginPassword();
    notifyListeners();
  }

  void toggleLoginPasswordVisibility() {
    _isLoginPasswordVisible = !_isLoginPasswordVisible;
    notifyListeners();
  }

  void setLoginFormActive(bool value) {
    if (_isLoginFormActive == value) return;
    _isLoginFormActive = value;
    notifyListeners();
  }

  Future<void> signInWithEmail() async {
    _loginHasSubmitted = true;
    validateLoginEmail();
    validateLoginPassword();

    if (!isLoginFormValid) return;

    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      // Simulate wrong password → show forgot password
      _showForgotPassword = true;
      _loginPasswordError = 'Incorrect password. Please try again.';
      _status = AuthStatus.error;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void resetLogin() {
    _loginEmail = '';
    _loginPassword = '';
    _isLoginPasswordVisible = false;
    _isLoginFormActive = false;
    _loginEmailError = null;
    _loginPasswordError = null;
    _loginHasSubmitted = false;
    _showForgotPassword = false;
    _status = AuthStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SIGNUP STATE
  // ═══════════════════════════════════════════════════════════════════════════
  String _signupEmail = '';
  String _signupPassword = '';
  String _signupConfirmPassword = '';
  bool _isSignupPasswordVisible = false;
  bool _isSignupConfirmPasswordVisible = false;
  bool _isSignupFormActive = false;
  String? _signupEmailError;
  String? _signupPasswordError;
  String? _signupConfirmPasswordError;
  bool _signupHasSubmitted = false;

  String get signupEmail => _signupEmail;
  String get signupPassword => _signupPassword;
  String get signupConfirmPassword => _signupConfirmPassword;
  bool get isSignupPasswordVisible => _isSignupPasswordVisible;
  bool get isSignupConfirmPasswordVisible => _isSignupConfirmPasswordVisible;
  bool get isSignupFormActive => _isSignupFormActive;
  String? get signupEmailError => _signupEmailError;
  String? get signupPasswordError => _signupPasswordError;
  String? get signupConfirmPasswordError => _signupConfirmPasswordError;

  bool get isSignupFormValid {
    final emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(_signupEmail) &&
        _signupPassword.length >= 7 &&
        _signupPassword == _signupConfirmPassword;
  }

  void validateSignupEmail() {
    final emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[a-zA-Z]{2,}$');
    if (_signupEmail.isEmpty) {
      _signupEmailError = 'Email is required';
    } else if (!emailRegex.hasMatch(_signupEmail)) {
      _signupEmailError = 'Enter a valid email (e.g. name@example.com)';
    } else {
      _signupEmailError = null;
    }
    notifyListeners();
  }

  void validateSignupPassword() {
    if (_signupPassword.isEmpty) {
      _signupPasswordError = 'Password is required';
    } else if (_signupPassword.length < 7) {
      _signupPasswordError = 'Password must be at least 7 characters';
    } else {
      _signupPasswordError = null;
    }
    notifyListeners();
  }

  void validateSignupConfirmPassword() {
    if (_signupConfirmPassword.isEmpty) {
      _signupConfirmPasswordError = 'Please confirm your password';
    } else if (_signupConfirmPassword != _signupPassword) {
      _signupConfirmPasswordError = 'Passwords do not match';
    } else {
      _signupConfirmPasswordError = null;
    }
    notifyListeners();
  }

  void updateSignupEmail(String value) {
    _signupEmail = value;
    _isSignupFormActive = true;
    if (_signupHasSubmitted) validateSignupEmail();
    notifyListeners();
  }

  void updateSignupPassword(String value) {
    _signupPassword = value;
    _isSignupFormActive = true;
    if (_signupHasSubmitted) validateSignupPassword();
    notifyListeners();
  }

  void updateSignupConfirmPassword(String value) {
    _signupConfirmPassword = value;
    _isSignupFormActive = true;
    if (_signupHasSubmitted) validateSignupConfirmPassword();
    notifyListeners();
  }

  void toggleSignupPasswordVisibility() {
    _isSignupPasswordVisible = !_isSignupPasswordVisible;
    notifyListeners();
  }

  void toggleSignupConfirmPasswordVisibility() {
    _isSignupConfirmPasswordVisible = !_isSignupConfirmPasswordVisible;
    notifyListeners();
  }

  void setSignupFormActive(bool value) {
    if (_isSignupFormActive == value) return;
    _isSignupFormActive = value;
    notifyListeners();
  }

  Future<void> signUpWithEmail() async {
    _signupHasSubmitted = true;
    validateSignupEmail();
    validateSignupPassword();
    validateSignupConfirmPassword();

    if (!isSignupFormValid) return;

    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _status = AuthStatus.success;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void resetSignup() {
    _signupEmail = '';
    _signupPassword = '';
    _signupConfirmPassword = '';
    _isSignupPasswordVisible = false;
    _isSignupConfirmPasswordVisible = false;
    _isSignupFormActive = false;
    _signupEmailError = null;
    _signupPasswordError = null;
    _signupConfirmPasswordError = null;
    _signupHasSubmitted = false;
    _status = AuthStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // RECOVERY STATE
  // ═══════════════════════════════════════════════════════════════════════════
  String _recoveryEmail = '';
  bool _isRecoveryFormActive = false;
  String? _recoveryEmailError;
  bool _recoveryHasSubmitted = false;

  String get recoveryEmail => _recoveryEmail;
  bool get isRecoveryFormActive => _isRecoveryFormActive;
  String? get recoveryEmailError => _recoveryEmailError;

  bool get isRecoveryFormValid {
    final emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(_recoveryEmail);
  }

  void validateRecoveryEmail() {
    final emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[a-zA-Z]{2,}$');
    if (_recoveryEmail.isEmpty) {
      _recoveryEmailError = 'Email is required';
    } else if (!emailRegex.hasMatch(_recoveryEmail)) {
      _recoveryEmailError = 'Enter a valid email (e.g. name@example.com)';
    } else {
      _recoveryEmailError = null;
    }
    notifyListeners();
  }

  void updateRecoveryEmail(String value) {
    _recoveryEmail = value;
    _isRecoveryFormActive = true;
    if (_recoveryHasSubmitted) validateRecoveryEmail();
    notifyListeners();
  }

  void setRecoveryFormActive(bool value) {
    if (_isRecoveryFormActive == value) return;
    _isRecoveryFormActive = value;
    notifyListeners();
  }

  Future<void> sendRecoveryLink(BuildContext context) async {
    _recoveryHasSubmitted = true;
    validateRecoveryEmail();

    if (!isRecoveryFormValid) return;

    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _status = AuthStatus.success;
      notifyListeners();

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OtpScreen()),
        );
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void resetRecovery() {
    _recoveryEmail = '';
    _isRecoveryFormActive = false;
    _recoveryEmailError = null;
    _recoveryHasSubmitted = false;
    _status = AuthStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SOCIAL AUTH (shared)
  // ═══════════════════════════════════════════════════════════════════════════
  Future<void> continueWithGoogle() async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _status = AuthStatus.success;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> continueWithApple() async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _status = AuthStatus.success;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // OTP STATE
  // ═══════════════════════════════════════════════════════════════════════════
  List<String> _otpDigits = ['', '', '', ''];
  String? _otpError;
  bool _otpHasSubmitted = false;

  List<String> get otpDigits => _otpDigits;
  String? get otpError => _otpError;

  bool get isOtpValid => _otpDigits.every((d) => d.isNotEmpty);

  void updateOtpDigit(int index, String value) {
    _otpDigits[index] = value;
    if (_otpHasSubmitted) validateOtp();
    notifyListeners();
  }

  void validateOtp() {
    if (!isOtpValid) {
      _otpError = 'Please enter the complete OTP';
    } else {
      _otpError = null;
    }
    notifyListeners();
  }

  Future<void> verifyOtp() async {
    _otpHasSubmitted = true;
    validateOtp();
    if (!isOtpValid) return;

    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _status = AuthStatus.success;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> resendOtp(BuildContext context) async {
    _otpDigits = ['', '', '', ''];
    _otpError = null;
    _otpHasSubmitted = false;
    notifyListeners();
    await sendRecoveryLink(context);
  }

  void resetOtp() {
    _otpDigits = ['', '', '', ''];
    _otpError = null;
    _otpHasSubmitted = false;
    _status = AuthStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SET NEW PASSWORD STATE
  // ═══════════════════════════════════════════════════════════════════════════
  String _newPassword = '';
  bool _isNewPasswordVisible = false;
  String? _newPasswordError;
  bool _newPasswordHasSubmitted = false;

  String get newPassword => _newPassword;
  bool get isNewPasswordVisible => _isNewPasswordVisible;
  String? get newPasswordError => _newPasswordError;

  bool get isNewPasswordValid => _newPassword.length >= 8;

  void validateNewPassword() {
    if (_newPassword.isEmpty) {
      _newPasswordError = 'Password is required';
    } else if (_newPassword.length < 8) {
      _newPasswordError = 'Password must be at least 8 characters';
    } else {
      _newPasswordError = null;
    }
    notifyListeners();
  }

  void updateNewPassword(String value) {
    _newPassword = value;
    if (_newPasswordHasSubmitted) validateNewPassword();
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible = !_isNewPasswordVisible;
    notifyListeners();
  }

  Future<void> confirmNewPassword(BuildContext context) async {
    _newPasswordHasSubmitted = true;
    validateNewPassword();
    if (!isNewPasswordValid) return;

    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _status = AuthStatus.success;
      notifyListeners();

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false, // clears entire stack
        );
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void resetNewPassword() {
    _newPassword = '';
    _isNewPasswordVisible = false;
    _newPasswordError = null;
    _newPasswordHasSubmitted = false;
    _status = AuthStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
