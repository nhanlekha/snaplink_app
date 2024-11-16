import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../components/theme/colors.dart';
import '../../../components/widget_custom/thumb_list.dart';

List<String> dance = [
  'assets/thumbnails/dance/Layer 951.png',
  'assets/thumbnails/dance/Layer 952.png',
  'assets/thumbnails/dance/Layer 953.png',
  'assets/thumbnails/dance/Layer 954.png',
  'assets/thumbnails/dance/Layer 951.png',
  'assets/thumbnails/dance/Layer 952.png',
  'assets/thumbnails/dance/Layer 953.png',
  'assets/thumbnails/dance/Layer 954.png',
];
List<String> lol = [
  'assets/thumbnails/lol/Layer 978.png',
  'assets/thumbnails/lol/Layer 979.png',
  'assets/thumbnails/lol/Layer 980.png',
  'assets/thumbnails/lol/Layer 981.png',
];
List<String> food = [
  'assets/thumbnails/food/Layer 783.png',
  'assets/thumbnails/food/Layer 784.png',
  'assets/thumbnails/food/Layer 785.png',
  'assets/thumbnails/food/Layer 786.png',
  'assets/thumbnails/food/Layer 787.png',
  'assets/thumbnails/food/Layer 788.png',
];

List<String> carouselImages = [
  "assets/images/banner 1.png",
  "assets/images/banner 2.png",
];

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExploreBody();
  }
}

class ExploreBody extends StatefulWidget {
  @override
  _ExploreBodyState createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  @override
  void dispose() {
    super.dispose();
    // _anchoredBanner?.dispose();
  }

  final List<ThumbList> thumbLists = [
    ThumbList(dance),
    ThumbList(lol),
    ThumbList(food),
    ThumbList(dance),
    ThumbList(lol),
    ThumbList(food),
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<TitleRow> titleRows = [
      TitleRow('danceLike'.tr(), '159.8k', dance),
      TitleRow('laughOut'.tr(), '108.9k', lol),
      TitleRow('followUr'.tr(), '159.8k', food),
      TitleRow('danceLike'.tr(), '159.8k', dance),
      TitleRow('laughOut'.tr(), '108.9k', lol),
      TitleRow('followUr'.tr(), '159.8k', food),
    ];
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Scaffold(
            body: FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Stack(
                    children: [
                      CarouselSlider(
                        items: carouselImages.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                    child: FadedScaleAnimation(
                                  child: Image.asset(i),
                                )),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            autoPlay: true,
                            aspectRatio: 3,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        end: 20.0,
                        bottom: 0.0,
                        child: Row(
                          children: carouselImages.map((i) {
                            int index = carouselImages.indexOf(i);

                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : disabledTextColor.withOpacity(0.5),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: titleRows.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            titleRows[index],
                            thumbLists[index],
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TitleRow extends StatelessWidget {
  final String? title;
  final String subTitle;
  final List list;

  TitleRow(this.title, this.subTitle, this.list);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: darkColor,
        child: Text(
          '#',
          style: TextStyle(color: mainColor),
        ),
      ),
      title: Text(
        title!,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Row(
        children: <Widget>[
          Text(
            subTitle + ' ' + 'video'.tr(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Spacer(),
          Text(
            'viewAll'.tr(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: secondaryColor,
            size: 10,
          ),
        ],
      ),
      onTap: () => {},
    );
  }
}
