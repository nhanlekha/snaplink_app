import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routers/app_route_constants.dart';
import '../../../components/theme/colors.dart';

class ListChatScreens extends StatefulWidget {
  const ListChatScreens({super.key});

  @override
  _ListChatScreensState createState() => _ListChatScreensState();
}

class Notif {
  final String name;
  final String? desc;
  final String time;
  final String image;
  final String notifImage;
  final IconData icon;

  Notif(
      this.name, this.desc, this.time, this.image, this.notifImage, this.icon);
}

List<Notif> notification = [
  Notif(
      "Emili Williamson",
      'likedYourVideo',
      "5 minAgo",
      "assets/user/user1.png",
      "assets/thumbnails/dance/Layer 951.png",
      Icons.favorite),
  Notif("Kesha Taylor", 'likedYourVideo', "5 minAgo", "assets/user/user2.png",
      "assets/thumbnails/dance/Layer 952.png", Icons.message),
];

List<String?> messages = [
  'heyILikeYourVideos',
  'yesIUse',
];

class _ListChatScreensState extends State<ListChatScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Tab(text: 'Tin Nhan'),
        actions: [
          InkWell(
            child: const Icon(Icons.search),
            onTap: () {
              context.push(RouteConstants.upSearchRoute);
            },
          )
        ],
      ),
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: MessagesPage(notification: notification, messages: messages),
      ),
    );
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({
    super.key,
    required this.notification,
    required this.messages,
  });

  final List<Notif> notification;
  final List<String?> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage(notification[index].image)),
            title: Text(
              notification[index].name,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    messages[index]!,
                    style: const TextStyle(color: Colors.blueGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            trailing: Text(
              notification[index].time,
              style: TextStyle(color: lightTextColor.withOpacity(0.15)),
            ),
            onTap: () {},
          );
        });
  }
}
