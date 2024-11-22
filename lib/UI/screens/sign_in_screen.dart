import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:t_manager/UI/Controllers/auth_controller.dart';
import 'package:t_manager/UI/screens/forgot_password_screen.dart';
import 'package:t_manager/UI/screens/main_bottom_nav_bar_screen.dart';
import 'package:t_manager/UI/screens/sign_up_screen.dart';
import 'package:t_manager/UI/utils/app_color.dart';
import 'package:t_manager/UI/widgets/center_circular_progress_indicator.dart';
import 'package:t_manager/UI/widgets/screen_background.dart';
import 'package:t_manager/UI/widgets/show_snack_bar.dart';
import 'package:t_manager/data/models/network_responses.dart';
import 'package:t_manager/data/services/network_caller.dart';
import 'package:t_manager/data/utils/urls.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  'Get Started with',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 24,
                ),
                _sign_in_form(),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPassword,
                        child: const Text('Forgot Password?'),
                      ),
                      _SignUp(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  Widget _sign_in_form() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid E-mail!';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordTEController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Password!';
              }
              if (value!.length <= 2) {
                return 'Please enter more than 2 Characters!';
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inProgress,
            replacement: CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SignUp() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.6,
        ),
        text: "Don't have an account? ",
        children: [
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(color: AppColor.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapsignUpButton,
          )
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _SignIn();
  }

  Future<void> _SignIn() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestbody = {
      'email': _emailTEController.text.trim(),
      'password': _passwordTEController.text,
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestbody);
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      await AuthController.saveAccessToken(response.responseData['token']);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavBarScreen(),
        ),
        (value) => false,
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapsignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }
}
