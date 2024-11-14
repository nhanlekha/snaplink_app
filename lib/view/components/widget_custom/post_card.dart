import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snaplink_app/ultils/extensions.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: BorderDirectional(
            top: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://cdn.dribbble.com/users/1998175/avatars/normal/af46ac7b92eb85f76f5a3fe4f214fdf2.jpg?1542363868",
                        imageBuilder: (context, imageProvider) => Container(
                          width: context.mediaQueryWidth * 0.12,
                          height: context.mediaQueryWidth * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Lalala",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.ellipsis,
                          color: Colors.black))
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://cdn.dribbble.com/userupload/16907339/file/original-e9564f1281bbd4e956f11b047422bb9a.jpg?resize=1600x1200",
                imageBuilder: (context, imageProvider) => Container(
                  width: context.mediaQueryWidth,
                  height: context.mediaQueryHeight * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            iconSize: 18,
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.heart,
                              color: Colors.black,
                            )),
                        const Text("132")
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        IconButton(
                            iconSize: 18,
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.comment,
                              color: Colors.black,
                            )),
                        const Text("12")
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        IconButton(
                            iconSize: 18,
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.paperPlane,
                              color: Colors.black,
                            )),
                        const Text("12")
                      ],
                    ),
                  ],
                ),
                IconButton(
                    iconSize: 18,
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.bookmark,
                        color: Colors.black))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
