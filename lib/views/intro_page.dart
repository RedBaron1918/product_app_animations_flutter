import 'package:app_with_animations/model/intor_model.dart';
import 'package:app_with_animations/views/home_page.dart';
import 'package:app_with_animations/widgets/title_animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List _lottieUrls = [
    Intro(
        img: "https://assets2.lottiefiles.com/packages/lf20_bqnjxnmy.json",
        text: "Order your Food"),
    Intro(
        img: "https://assets6.lottiefiles.com/packages/lf20_s4tzxvwu.json",
        text: "With Fast Delivery"),
    Intro(
        img: "https://assets1.lottiefiles.com/private_files/lf30_nocwwn6m.json",
        text: "Enjoy Your Food"),
  ];
  int _activePage = 0;
  List<Widget> _buildIndicators(int imagesLength, int currentIndex) {
    return List<Widget>.generate(
      imagesLength,
      (index) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Colors.white
                : const Color.fromARGB(255, 216, 216, 216),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          PageView.builder(
            pageSnapping: true,
            onPageChanged: (page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _lottieUrls.length,
            itemBuilder: (context, index) {
              return _BuildPage(intro: _lottieUrls[index]);
            },
          ),
          Positioned(
            bottom: 150,
            right: 0.0,
            left: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicators(_lottieUrls.length, _activePage),
            ),
          ),
          Positioned(
            bottom: 83,
            right: 120.0,
            left: 120.0,
            child: MaterialButton(
              padding: const EdgeInsets.all(15),
              color: const Color.fromARGB(255, 252, 252, 252),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomePage(),
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
              child: Text(
                _activePage == _lottieUrls.length - 1 ? "Start" : "Skip",
                style: const TextStyle(color: Colors.blueAccent, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildPage extends StatelessWidget {
  final Intro intro;

  const _BuildPage({
    required this.intro,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadLottieAnimation(intro.img ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 100)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Positioned(
                      top: 170,
                      right: 0.0,
                      left: 65.0,
                      child: TitleAnimation(text: "${intro.text}"),
                    ),
                    Positioned(
                      top: 200,
                      right: 0.0,
                      left: 0.0,
                      child: Lottie.network(intro.img ?? ''),
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _loadLottieAnimation(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load Lottie animation');
    }
  }
}
