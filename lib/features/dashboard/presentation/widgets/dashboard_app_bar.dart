part of '../page/dashboard_page.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: anchorCustomAppBar.addTopHeightMenubar(context),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Dashboard", style: context.textTheme.titleLarge),
              ),
              Text(formatDate(DateTime.now())),
              SizedBox(width: kSizeMS),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(OnSignOutEvent());
                },
                child: Row(
                  children: [
                    Icon(CupertinoIcons.square_arrow_right, color: darkColor),
                    SizedBox(width: 6),
                    Text(
                      "Keluar",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeSS),
          CustomTab(
            currentIndex: 0,
            menus: ["Minggu", "Bulan", "Tahun"],
            changeMenu: (menu) {},
          ),
        ],
      ),
    );
  }
}
