import 'package:flutter/material.dart';

import '../../../ultils/enums/onbroarding_page_pos.dart';

class OnboardingChildPage extends StatelessWidget {
  final OnBoardingPos onBoardingPos;
  final VoidCallback nextOnPressed;
  final VoidCallback backOnPressed;
  final VoidCallback skipOnPressed;

  const OnboardingChildPage({super.key, required this.onBoardingPos, required this.nextOnPressed, required this.backOnPressed, required this.skipOnPressed});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSkipButton(),
            _buildOnboardingImage(),
            _buildOnboardingPageControl(),
            _buildOnboardingTitleContent(),
            _buildOnboardingNextAndPrevButton(),
          ],
          ),
        ),)
    );
  }

  Widget _buildSkipButton(){
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.only(top: 14),
      child: TextButton(onPressed: (){

      },
          child: TextButton(
            onPressed: () { skipOnPressed.call(); },
            child: const Text("SKIP" ,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Lato",
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          )
      ),
    );
  }

  Widget _buildOnboardingImage(){
    return Image.asset(
      onBoardingPos.onBoardingPageImage(),
      width: 296,
      height: 271,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnboardingPageControl(){

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          height: 4,
          width: 26,
          decoration: BoxDecoration(
            color: onBoardingPos == OnBoardingPos.page1 ? Colors.white : Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(56),
          ),
        ),
        Container(
          height: 4,
          width: 26,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: onBoardingPos == OnBoardingPos.page2 ? Colors.white : Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(56),
          ),
        ),
        Container(
          height: 4,
          width: 26,
          decoration: BoxDecoration(
            color: onBoardingPos == OnBoardingPos.page3 ? Colors.white : Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(56),
          ),
        ),
      ],),
    );
  }

  Widget _buildOnboardingTitleContent(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text(onBoardingPos.onBoardingPageTitle(),
               style: TextStyle(
                   color: Colors.white.withOpacity(0.87),
                 fontFamily: "Lato",
                 fontSize: 32,
                 fontWeight: FontWeight.bold,
               ),
             textAlign: TextAlign.center,
           ),
           const SizedBox(height: 42),
           Text(onBoardingPos.onBoardingPageContent(),
               style: TextStyle(
                 color: Colors.white.withOpacity(0.87),
                 fontFamily: "Lato",
                 fontSize: 16,
               ),
             textAlign: TextAlign.center,
           ),
         ],
       ),
    );
  }

  Widget _buildOnboardingNextAndPrevButton(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 250,bottom: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: (){
                backOnPressed.call();
              },
              child: Text("BACK",
                style: TextStyle(
                color: Colors.white.withOpacity(0.44),
                fontFamily: "Lato",
                fontSize: 16,
              ),
              )
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: (){
                nextOnPressed.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8875FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
              ),
              child: Text( onBoardingPos == OnBoardingPos.page3 ? "GET START" : "NEXT",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.44),
                  fontFamily: "Lato",
                  fontSize: 16,

                ),

              )
          ),
        ],
      ),
    );
  }
}
