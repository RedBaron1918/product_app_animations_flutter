import 'package:app_with_animations/model/category_model.dart';
import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/utils/service.dart';
import 'package:app_with_animations/widgets/category_card_widget.dart';
import 'package:app_with_animations/widgets/future_widget.dart';
import 'package:app_with_animations/widgets/product_list_widget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  final categoryCardModelList = <CategoryCardModel>[
    CategoryCardModel("smartphones"),
    CategoryCardModel("laptops"),
    CategoryCardModel("skincare"),
    CategoryCardModel("groceries"),
    CategoryCardModel("home-decoration")
  ];
  CategoryCardModel? _selectedCardModel;
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CategoryListWidget(
        categoryCardModelList: categoryCardModelList,
        selectedCardModel: _selectedCardModel,
        onCategorySelected: (category) {
          setState(() {
            _selectedCardModel = category;
          });
        },
        animation: _animation,
      ),
      FutureWidget(
        futureData: Services.fetchProductData(),
        builder: (AsyncSnapshot<ProductList> snapshot) {
          return ProductListWidget(
            animation: _animation,
            snapshot: snapshot,
            selectedCardModel: _selectedCardModel,
          );
        },
      ),
    ]);
  }
}

class CategoryListWidget extends StatefulWidget {
  final List<CategoryCardModel> categoryCardModelList;
  final CategoryCardModel? selectedCardModel;
  final Function(CategoryCardModel) onCategorySelected;
  final Animation<Offset> animation;

  const CategoryListWidget({
    super.key,
    required this.categoryCardModelList,
    required this.selectedCardModel,
    required this.onCategorySelected,
    required this.animation,
  });

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: AnimatedList(
        key: GlobalKey<AnimatedListState>(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        initialItemCount: widget.categoryCardModelList.length,
        itemBuilder: (context, index, animation) {
          final categoryCardModel = widget.categoryCardModelList[index];
          return SlideTransition(
            position: widget.animation,
            child: CategoryCard(
              wasPressed: () {
                widget.onCategorySelected(categoryCardModel);
              },
              categoryCardName: categoryCardModel.categoryCardModelName,
              isSelected: widget.selectedCardModel == categoryCardModel,
            ),
          );
        },
      ),
    );
  }
}
