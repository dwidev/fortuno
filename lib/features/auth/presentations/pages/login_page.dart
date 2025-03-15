import '../../../../core/constants/images_assets.dart';
import '../../../../core/core.dart';
import '../bloc/auth_bloc.dart';
import 'welcome_page.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 3, child: WelcomePage()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(kSizeXXL),
              decoration: BoxDecoration(color: whiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fortuno POS",
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    "Kendali Bisnis di Ujung Jari, Laba Melesat Setiap Hari!",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: darkColor,
                    ),
                  ),
                  SizedBox(height: kSizeM),
                  GradientButton(
                    width: 300,
                    onPressed: () async {
                      context.read<AuthBloc>().add(OnSignWithGoogleEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(googlePng, width: 25, height: 25),
                        SizedBox(width: kSizeS),
                        Text(
                          "Sign with Google",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: darkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
