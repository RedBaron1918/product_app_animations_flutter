import 'package:app_with_animations/views/cart_page.dart';
import 'package:app_with_animations/widgets/category_widget.dart';
import 'package:app_with_animations/widgets/fade_in_image.dart';
import 'package:app_with_animations/widgets/search_bar_widget.dart';
import 'package:app_with_animations/widgets/title_animation.dart';
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
        title: const TitleAnimationWidget(
          text: "Menu",
          textColor: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CartPage(),
                    transitionDuration: const Duration(milliseconds: 600),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0), end: Offset.zero)
                            .animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [SearchBarWidget(), CategoryWidget()],
        ),
      ),
    );
  }
}
