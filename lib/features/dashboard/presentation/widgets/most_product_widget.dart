part of '../page/dashboard_page.dart';

class MostProductWidget extends StatelessWidget {
  const MostProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      "Paket Hemat Berkah 16K Ayam Bakar",
      "Paket Hemat Berkah 16K Ayam Goreng",
      "Paket Kue 10K",
    ];
    return CustomCard(
      width: double.infinity,
      margin: [anchorRightContent, anchorBottomContent].merge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  CupertinoIcons.heart_fill,
                  size: kSizeM,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: kSizeMS),
              Text(
                "Paling sering dipesan",
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeM),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: kSizeS),
                    padding: EdgeInsets.all(kSizeS),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                        kDefaultRadius * 0.5,
                      ),
                      color: lightGrey8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(
                              kDefaultRadius * 0.5,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://cdn.prod.website-files.com/6346686a30512816becfbf47/671ed63b8d688b6b1d10a0ec_freepik__retouch__32461.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: kSizeS),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data[index],
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kSizeS * 0.9,
                                  ),
                                ),
                              ),
                              SizedBox(width: kSizeM),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "20x",
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: kSizeS,
                                          color: secondaryColor,
                                        ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "200 pcs",
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: kSizeS,
                                          color: secondaryColor,
                                        ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
