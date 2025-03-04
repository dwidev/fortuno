import 'package:flutter/material.dart';
import 'package:fortuno/core/constants/images_assets.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/extensions/extensions.dart';
import 'package:fortuno/core/theme/colors.dart';
import 'package:fortuno/features/order/pages/create_order_page.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(kSizeXXL),
              color: whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fortuno POS",
                    style: context.textTheme.displayMedium?.copyWith(
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
                  SizedBox(height: kSizeXL),
                  Text(
                    "Selamat datang, Masuk ke akun Anda!",
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: darkColor,
                    ),
                  ),
                  SizedBox(height: kSizeM),
                  GradientButton(
                    width: 300,
                    onPressed: () {
                      context.go(CreateOrderPage.path);
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
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [sunKissedYellowColor, lemonChiffonColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
