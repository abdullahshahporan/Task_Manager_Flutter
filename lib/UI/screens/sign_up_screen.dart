import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:t_manager/UI/utils/app_color.dart';
import 'package:t_manager/UI/widgets/center_circular_progress_indicator.dart';
import 'package:t_manager/UI/widgets/screen_background.dart';
import 'package:t_manager/UI/widgets/show_snack_bar.dart';
import 'package:t_manager/data/models/network_responses.dart';
import 'package:t_manager/data/services/network_caller.dart';
import 'package:t_manager/data/utils/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEConteroller = TextEditingController();
  final TextEditingController _firstnameTEConteroller = TextEditingController();
  final TextEditingController _lastnameTEConteroller = TextEditingController();
  final TextEditingController _mobilenoTEConteroller = TextEditingController();
  final TextEditingController _passwordTEConteroller = TextEditingController();
  bool _inprogress = false;

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
                  'join With Us',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 24,
                ),
                _sign_Up_form(),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _SignIn(),
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

  Widget _SignIn() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.6,
        ),
        text: "Have account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(color: AppColor.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapsignInButton,
          )
        ],
      ),
    );
  }

  Widget _sign_Up_form() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEConteroller,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a valid E-mail';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _firstnameTEConteroller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'first Name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter Your First Name';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _lastnameTEConteroller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Last Name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter Your Last Name';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _mobilenoTEConteroller,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Mobile No.'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter Your Correct Mobile Number';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordTEConteroller,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter Your Password';
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inprogress,
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

  void _onTapNextButton() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _signUp();
  }

  Future<void> _signUp() async {
    _inprogress = true;
    setState(() {});
    Map<String,dynamic> requestBody={
      "email":_emailTEConteroller.text.trim(),
      "firstName":_firstnameTEConteroller.text.trim(),
      "lastName":_lastnameTEConteroller.text.trim(),
      "mobile": _mobilenoTEConteroller.text.trim(),
      "password":_passwordTEConteroller.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
       url: Urls.registration,
    body: requestBody,
    );
    _inprogress=false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New User Created Successfully');
    }
    else
      {
        showSnackBarMessage(context, response.errorMessage,true);

      }
  }
  void _clearTextFields()
  {
    _emailTEConteroller.clear();
    _firstnameTEConteroller.clear();
    _lastnameTEConteroller.clear();
    _mobilenoTEConteroller.clear();
    _passwordTEConteroller.clear();
  }

  void _onTapsignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEConteroller.dispose();
    _firstnameTEConteroller.dispose();
    _lastnameTEConteroller.dispose();
    _mobilenoTEConteroller.dispose();
    _emailTEConteroller.dispose();
    super.dispose();
  }
}
