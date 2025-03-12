// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/core.dart';
import '../../../products/domain/entities/package.dart';

class PackageListWidget extends StatelessWidget {
  const PackageListWidget({
    super.key,
    required this.packages,
    required this.onTap,
  });

  final List<Package> packages;
  final Function(Package package) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ).copyWith(top: kSizeM),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(packages.length + 1, (index) {
            if (index == 0) {
              return InkWell(
                borderRadius: BorderRadius.circular(kDefaultRadius),
                onTap: () {},
                child: Ink(
                  padding: EdgeInsets.all(kDefaultPadding * 0.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                    color: index % 2 == 1 ? lemonChiffonColor : whiteColor,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.add_circled,
                        size: kSizeL,
                        color: darkOliveGreen,
                      ),
                      SizedBox(height: kSizeS),
                      Text(
                        "Buat package",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: darkOliveGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final package = packages[index - 1];

            return InkWell(
              borderRadius: BorderRadius.circular(kDefaultRadius),
              onTap: () {
                onTap(package);
              },
              child: Ink(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: index % 2 == 1 ? lemonChiffonColor : whiteColor,
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: darkLightColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          "https://www.lalamove.com/hubfs/catering%20lunch%20box%20%284%29.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: kSizeS),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(
                            package.name,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: darkOliveGreen,
                            ),
                          ),
                        ),
                        SizedBox(height: kSizeS),
                        Container(
                          constraints: BoxConstraints(maxWidth: 130),
                          child: Text(
                            package.contents,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: darkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (index % 2 == 1)
                      Container(
                        margin: EdgeInsets.only(left: kSizeS),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: darkOliveGreen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "x200",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
