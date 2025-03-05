import 'package:flutter_svg/svg.dart';
import 'package:fortuno/core/constants/svg_assets.dart';
import 'package:fortuno/core/core.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.svg,
    required this.length,
    required this.currentIndex,
  });

  final String title;
  final String desc;
  final String svg;
  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(svg, width: context.width / 2.9),
        SizedBox(height: kSizeM),
        SizedBox(
          width: context.width / 2.5,
          child: Text(
            title,
            style: context.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: kSizeM),
        Text(
          desc,
          style: context.textTheme.titleSmall?.copyWith(color: darkColor),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: kSizeM),
      ],
    );
  }
}

class WelcomePageData {
  final String svg;
  final String title;
  final String desc;

  WelcomePageData({required this.svg, required this.title, required this.desc});

  static List<WelcomePageData> create() {
    return [
      WelcomePageData(
        svg: graficSvg,
        title: "Fortuno POS – Kelola Bisnis, Tanpa Ribet!",
        desc:
            "Mulai pencatatan transaksi, kelola stok, dan pantau laporan harian dalam satu aplikasi.",
      ),
      WelcomePageData(
        svg: branchSvg,
        title: "Kelola Bisnis mu dimana saja!",
        desc: "Lihat perkembangan bisnismu dimana saja dan kapan pun",
      ),
      WelcomePageData(
        svg: responsiveAppSvg,
        title: "Lebih dari Sekadar POS, Solusi Bisnis Cerdas!",
        desc:
            "Dengan fitur yang bisa disesuaikan, Fortuno POS membantu bisnismu berkembang lebih cepat.",
      ),
      WelcomePageData(
        svg: teamSvg,
        title: "Kelola Tim, Tingkatkan Produktivitas!",
        desc:
            "Atur peran, pantau kinerja, dan jalankan bisnis lebih efisien dengan Fortuno POS.",
      ),
    ];
  }
}
