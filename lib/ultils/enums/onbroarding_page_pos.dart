enum OnBoardingPos{
  page1,
  page2,
  page3
}


extension OnBoardingPagePosExtension on OnBoardingPos{
  String onBoardingPageImage() {
    switch (this) {
      case OnBoardingPos.page1:
      // TODO: Handle this case.
        return "assets/images/Onboarding_1.png";
      case OnBoardingPos.page2:
      // TODO: Handle this case.
        return "assets/images/Onboarding_2.png";
      case OnBoardingPos.page3:
      // TODO: Handle this case.
        return "assets/images/Onboarding_3.png";
    }
  }

  String onBoardingPageTitle() {
    switch (this) {
      case OnBoardingPos.page1:
      // TODO: Handle this case.
        return "Manage your tasks";
      case OnBoardingPos.page2:
      // TODO: Handle this case.
        return "Create daily routine";
      case OnBoardingPos.page3:
      // TODO: Handle this case.
        return "Orgonaize your tasks";
    }
  }

  String onBoardingPageContent() {
    switch (this) {
      case OnBoardingPos.page1:
      // TODO: Handle this case.
        return "You can easily manage all of your daily tasks in DoMe for free";
      case OnBoardingPos.page2:
      // TODO: Handle this case.
        return "In Uptodo  you can create your personalized routine to stay productive";
      case OnBoardingPos.page3:
      // TODO: Handle this case.
        return "You can organize your daily tasks by adding your tasks into separate categories";
    }
  }


}