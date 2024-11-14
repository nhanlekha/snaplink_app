import 'package:flutter/material.dart';
import 'package:snaplink_app/view/components/widget_custom/post_card.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          PostCard(),
        ],
      ),
    );
  }
}
