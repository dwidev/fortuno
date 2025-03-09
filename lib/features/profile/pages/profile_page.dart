import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/auth/presentations/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  static String path = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(OnSignOutEvent());
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
