import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:t_manager/UI/Controllers/auth_controller.dart';
import 'package:t_manager/UI/screens/main_bottom_nav_bar_screen.dart';
import 'package:t_manager/UI/screens/sign_in_screen.dart';
import 'package:t_manager/UI/utils/assets_path.dart';
import 'package:t_manager/UI/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movetonextscreen();
  }

  Future<void> _movetonextscreen() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    await AuthController.getAccessToken();

    if (AuthController.isLoggedIn()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavBarScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assetspath.logoSVG,
                width: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
