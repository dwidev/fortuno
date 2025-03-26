import 'package:fortuno/core/core.dart';

class SelectedProductWidget extends StatelessWidget {
  const SelectedProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Container(
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultRadius * 0.5),
              color: lightGrey7,
              border:
                  index == 1
                      ? Border.all(color: primaryColor, width: 0.7)
                      : null,
            ),
            margin: EdgeInsets.only(right: kSizeS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          kDefaultRadius * 0.5,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://cms.disway.id//uploads/0a89f2c48130e61ec0621d8bdd2d6b74.jpeg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (index == 1) ? primaryColor : lightGrey3,
                        ),
                        child:
                            index == 1
                                ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                                : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kSizeS),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSizeS),
                  child: Text(
                    "Nasi Box",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: kSizeS),
              ],
            ),
          );
        }),
      ),
    );
  }
}
