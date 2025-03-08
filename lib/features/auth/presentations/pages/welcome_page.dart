import 'dart:async';

import '../../../../core/core.dart';

import '../widgets/welcome_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late PageController pageController;
  late Timer timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1000);
    timer = Timer.periodic(Duration(seconds: 3), (tick) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
      setState(() {
        if (currentPage == WelcomePageData.create().length - 1) {
          currentPage = 0;
        } else {
          currentPage++;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    pageController.dispose();
  }

  int safeIndex(int index) => index % WelcomePageData.create().length;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [lemonChiffonColor, darkMossGreen],
          radius: 0.9,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.height / 1.5,
            child: PageView.builder(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = WelcomePageData.create()[safeIndex(index)];
                return WelcomeWidget(
                  svg: data.svg,
                  title: data.title,
                  desc: data.desc,
                  length: WelcomePageData.create().length,
                  currentIndex: safeIndex(index),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              WelcomePageData.create().length,
              (i) => Container(
                margin: EdgeInsets.only(right: 10),
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: i == currentPage ? darkColor : darkLightColor,
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
