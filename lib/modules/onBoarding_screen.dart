import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/Login/loginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel(
    this.image,
    this.title,
    this.body,
  );
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> onBoardingItems = [
    OnBoardingModel(
      'assets/images/onBoarding1.jpg',
      'Screen Title 1',
      'Screen body 1',
    ),
    OnBoardingModel(
      'assets/images/onBoarding2.png',
      'Title 2',
      'body 2',
    ),
    OnBoardingModel(
      'assets/images/onBoarding3.png',
      'Title 3',
      'body 3',
    ),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  var boardingController = PageController();
  bool isEnd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                "SKIP",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(onBoardingItems[index], isEnd),
                itemCount: onBoardingItems.length,
                onPageChanged: (int index) {
                  if (index == onBoardingItems.length - 1) {
                    setState(() {
                      isEnd = true;
                    });
                  } else {
                    setState(() {
                      isEnd = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: onBoardingItems.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 15.0,
                    activeDotColor: mainColor,
                    spacing: 5.0,
                    dotWidth: 15.0,
                    //type: WormType.thin,
                    expansionFactor: 4.0,
                    //strokeWidth: 50.0,
                    // paintStyle:
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isEnd) {
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: Duration(
                          milliseconds: 600,
                        ),
                        curve: Curves.easeInOutCirc,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(
  OnBoardingModel model,
  bool isEnd,
) =>
    Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              '${model.image}',
            ),
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
