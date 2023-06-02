import 'package:app_with_animations/consts/const_colors.dart';
import 'package:app_with_animations/widgets/fade_in_image.dart';
import 'package:app_with_animations/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Menu",
          style: TextStyle(
              color: ConstColors.titleColor,
              fontSize: 30,
              letterSpacing: 1,
              fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: FadeInImageWidget(
              photo:
                  "https://scontent.ftbs6-2.fna.fbcdn.net/v/t1.18169-9/1391743_603079143062900_1606433576_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=TfHiKTWsfFIAX8XzOu9&_nc_ht=scontent.ftbs6-2.fna&oh=00_AfCQbKXLcKZYYX5b1xFX4D-vQMrR2cxSoLrBgw7Uhs1Bww&oe=64A01ECA",
              radius: 90,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBarWidget(),
          ],
        ),
      ),
    );
  }
}
