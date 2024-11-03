import 'package:flutter/material.dart';

import '../../../ultils/enums/onbroarding_page_pos.dart';
import 'onboarding_child_page.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          OnboardingChildPage(
            onBoardingPos: OnBoardingPos.page1,
            nextOnPressed: () {
              _pageController.jumpToPage(1);
            },
            backOnPressed: () {
              // Add back button logic here if needed
            },
            skipOnPressed: () {
              _pageController.jumpToPage(2);
            },
          ),
          OnboardingChildPage(
            onBoardingPos: OnBoardingPos.page2,
            nextOnPressed: () {
              _pageController.jumpToPage(2);
            },
            backOnPressed: () {
              _pageController.jumpToPage(0);
            },
            skipOnPressed: () {
              _pageController.jumpToPage(2);
            },
          ),
          OnboardingChildPage(
            onBoardingPos: OnBoardingPos.page3,
            nextOnPressed: () {
              // Add next button logic here if needed
            },
            backOnPressed: () {
              _pageController.jumpToPage(1);
            },
            skipOnPressed: () {
              // Add skip button logic here if needed
            },
          ),
        ],

      ),
    );
  }
}
