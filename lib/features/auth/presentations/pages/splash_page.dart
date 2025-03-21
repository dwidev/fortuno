import '../../../../core/core.dart';

class SplashPage extends StatelessWidget {
  static const path = '/splash-page';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Fortuno POS",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: kSizeM),
        CircularProgressIndicator.adaptive(),
      ],
    );
  }
}
