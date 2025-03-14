import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/depedency_injection/injection.dart';
import '../../../core/environments/env_enum.dart';
import '../../auth/presentations/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  static String path = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final bloc = context.read<AuthBloc>();
            bloc.add(OnSignOutEvent());

            await bloc.stream.firstWhere((state) => state is LoggedOut);
            await getIt.reset();
            configureDepedencies(env: EnvApp.uat);
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
