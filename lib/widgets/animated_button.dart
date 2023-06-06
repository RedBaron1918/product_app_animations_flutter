import 'package:app_with_animations/consts/const_colors.dart';
import 'package:app_with_animations/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:app_with_animations/utils/get_cart.dart' as check_out_provider;

class AnimatedButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Color animationColor;
  final Product product;
  const AnimatedButton({
    Key? key,
    this.height,
    this.width,
    required this.product,
    required this.animationColor,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late Color textColor;
  late Color borderColor;
  late AnimationController _controller;
  late Animation _animation;
  late Animation _borderAnimation;
  bool _isInCart = false;

  @override
  void initState() {
    super.initState();
    isInCart();
    textColor = const Color.fromARGB(255, 95, 95, 95);
    borderColor = ConstColors.alizarin;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween(begin: 0.0, end: 500.0)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller))
      ..addListener(() {
        setState(() {});
      });
    _borderAnimation =
        ColorTween(begin: ConstColors.defaultColor, end: widget.animationColor)
            .animate(
      CurvedAnimation(curve: Curves.easeInOut, parent: _controller),
    );
  }

  void isInCart() async {
    _isInCart = await check_out_provider.isCheckOut(widget.product);
    setState(() {});
  }

  void _toggleCart() async {
    check_out_provider.saveCheckOut(widget.product.id.toString());
    _isInCart = !_isInCart;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: _borderAnimation.value,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: _toggleCart,
            onHover: (value) {
              if (value) {
                _controller.forward();
                setState(() {
                  textColor = Colors.white;
                  borderColor = widget.animationColor;
                });
              } else {
                _controller.reverse();
                setState(() {
                  textColor = const Color.fromARGB(255, 95, 95, 95);
                  borderColor = ConstColors.defaultColor;
                });
              }
            },
            child: Container(
              color: ConstColors.backgroundColor,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.animationColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      width: _animation.value,
                    ),
                  ),
                  Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      curve: Curves.easeIn,
                      child:
                          Text(_isInCart ? "Remove From Cart" : "Add To Cart"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
