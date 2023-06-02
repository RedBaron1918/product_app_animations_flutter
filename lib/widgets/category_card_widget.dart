import 'package:app_with_animations/consts/const_colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String? categoryCardName;
  final Function()? wasPressed;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.categoryCardName,
    this.wasPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: wasPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? ConstColors.titleColor
                : const Color.fromRGBO(242, 243, 243, 100),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            categoryCardName ?? 'Todas',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : ConstColors.titleColor),
          ),
        ),
      ),
    );
  }
}
