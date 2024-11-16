import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/theme/colors.dart';
import '../../components/widget_custom/profile_page_button.dart';
import 'explore/explore_page.dart';

class User {
  User(this.name, this.id, this.img);

  String name;
  String id;
  String img;
}

class SearchScreens extends StatefulWidget {
  @override
  _SearchScreensState createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  String? username;

  final _controller = TextEditingController();

  List<User> names = [
    User("Food Master", "@georgesmith", "assets/user/user1.png"),
    User("Foody Girl", "@emiliwilliamson", "assets/user/user2.png"),
    User("Foodzilla", "@foodyzilla", "assets/user/user3.png"),
    User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
    User("Opus Labs", "@opuslabs", "assets/user/user1.png"),
    User("Ling Tong", "@lingtong", "assets/user/user2.png"),
    User("Tosh Williamson", "@toshwilliamson", "assets/user/user3.png"),
    User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
    User("Food Master", "@georgesmith", "assets/user/user1.png"),
    User("Foody Girl", "@emiliwilliamson", "assets/user/user2.png"),
    User("Foodzilla", "@foodyzilla", "assets/user/user3.png"),
    User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextField(
                    controller: _controller,
                    onChanged: (val) {
                      username = val;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.black,
                        onPressed: () {
                          _controller.clear();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      border: InputBorder.none,
                      hintText: 'search'.tr(),
                      hintStyle: Theme.of(context).textTheme.titleMedium,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0), // Căn chỉnh khoảng cách
                    ),
                  ),
                ),
                TabBar(
                  indicator: BoxDecoration(color: transparentColor),
                  isScrollable: true,
                  labelColor: fbColor,
                  labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight:
                            FontWeight.bold, // Đặt chữ đậm cho tab được chọn
                      ),
                  unselectedLabelColor: disabledTextColor,
                  unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
                  // Định dạng cho tab không được chọn
                  tabs: const <Widget>[
                    Expanded(
                      child: Tab(
                        child: Text('Người dùng'),
                      ),
                    ),
                    Expanded(
                      child: Tab(
                        child: Text('Khám phá'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: username != null && username!.isNotEmpty
                  ? FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .where('name', isEqualTo: username)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("An error occurred: ${snapshot.error}"),
                          );
                        }

                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          return FadedSlideAnimation(
                            beginOffset: const Offset(0, 0.3),
                            endOffset: const Offset(0, 0),
                            slideCurve: Curves.linearToEaseOut,
                            child: Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data!.docs[index];

                                  return Column(
                                    children: <Widget>[
                                      Divider(
                                        color: Colors.grey.shade200,
                                        height: 1.0,
                                        thickness: 1,
                                      ),
                                      ListTile(
                                        leading: GestureDetector(
                                          child: FadedScaleAnimation(
                                            child: CircleAvatar(
                                              backgroundColor: darkColor,
                                              backgroundImage:
                                                  AssetImage(names[index].img),
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                        title: Text(
                                          doc['name'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(names[index].id),
                                        trailing: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child:
                                              FutureBuilder<DocumentSnapshot>(
                                            future: doc.reference
                                                .collection("followers")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              }

                                              if (snapshot.hasData &&
                                                  snapshot.data!.exists) {
                                                return ProfilePageButton(
                                                  color: Colors.red,
                                                  textColor: Colors.white,
                                                  text: 'UnFollow',
                                                  onTap: () async {
                                                    await doc.reference
                                                        .collection("followers")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .delete();
                                                    setState(() {});
                                                  },
                                                );
                                              } else {
                                                // Nếu tài liệu không tồn tại, hiển thị nút "Follow"
                                                return ProfilePageButton(
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  text: 'Follow',
                                                  onTap: () async {
                                                    await doc.reference
                                                        .collection("followers")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .set({
                                                      'time': DateTime.now()
                                                    });

                                                    QuerySnapshot q =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('chats')
                                                            .where('users',
                                                                arrayContains: [
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          doc.id,
                                                        ]).get();

                                                    print(FirebaseAuth.instance
                                                        .currentUser!.uid);

                                                    if (q.docs.isEmpty) {
                                                      //create new chat
                                                      print("No doc");
                                                      var data = {
                                                        //[ID - đăng nhập hiện tại. ID người muốn chat]

                                                        'users': [
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          doc.id
                                                        ],
                                                        'recent_text': 'Hi',
                                                      };

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("chats")
                                                          .add(data);
                                                    } else {
                                                      //start chat
                                                    }

                                                    setState(() {});
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        onTap: () => {},
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("No user found."),
                          );
                        }
                      },
                    )
                  : const Center(
                      child: Text("Please enter a username to search."),
                    ),
            ),
            FadedSlideAnimation(
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: ExplorePage(),
            ),
          ],
        ),
      ),
    );
  }
}
