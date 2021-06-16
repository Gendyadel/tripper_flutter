import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripper_flutter/components/custom_text_button.dart';
import 'package:tripper_flutter/models/on_boarding_model.dart';
import 'package:tripper_flutter/service/storage/cache_helper.dart';
import 'package:tripper_flutter/src/colors.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingList = [
    BoardingModel(
      image: 'assets/images/onBoardingTravelers.png',
      title: 'title',
      body: 'body',
    ),
    BoardingModel(
      image: 'assets/images/onBoardingSubway.png',
      title: 'title 2',
      body: 'body 2',
    ),
    BoardingModel(
      image: 'assets/images/onBoardingTelecommuting.png',
      title: 'title 3',
      body: 'body 3',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    var boardController = PageController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomTextButton(
            onPressed: _submit,
            text: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    _BoardingItem(boardingList[index]),
                itemCount: boardingList.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boardingList.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.blueGrey,
                    dotHeight: 12,
                    expansionFactor: 4,
                    spacing: 6,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      _submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
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

  void _submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndReplace(
          context,
          LoginScreen(),
        );
      }
    });
  }
}

class _BoardingItem extends StatelessWidget {
  final BoardingModel model;

  _BoardingItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('${model.image}'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
