import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/widgets/circle_icon.dart';
import 'package:app_with_animations/widgets/fade_in_image.dart';
import 'package:app_with_animations/widgets/icon_text_column.dart';
import 'package:app_with_animations/widgets/text_container.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(
      imagesLength,
      (index) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              color: currentIndex == index ? Colors.black : Colors.black26,
              shape: BoxShape.circle),
        );
      },
    );
  }

  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Positioned.fill(
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: PageView.builder(
                    itemCount: widget.product.images?.length,
                    pageSnapping: true,
                    onPageChanged: (page) {
                      setState(() {
                        activePage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      final photo = widget.product.images![index];
                      return FadeInImageWidget(
                        photo: photo,
                        radius: 6,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: CircleIcon(
                    iconSize: 25,
                    icon: Icons.arrow_back,
                    callBack: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 235.0,
                  right: 0.0,
                  left: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        indicators(widget.product.images?.length, activePage),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(right: 10, top: 10, child: Icon(Icons.abc)),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CardDetail(
              product: widget.product,
            ),
          )
        ]),
      ),
    );
  }
}

class CardDetail extends StatelessWidget {
  const CardDetail({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    List<IconTextWidgetColumn> icons = [
      IconTextWidgetColumn(
        backgroundColor: Colors.redAccent,
        icon: Icons.apartment_sharp,
        text: "brand",
        textColor: Colors.white,
        secondText: (product.brand?.length ?? 0) > 15
            ? '${product.brand!.substring(0, 15)}...'
            : product.brand ?? '',
        textSize: 15,
        color: Colors.white,
      ),
      IconTextWidgetColumn(
        backgroundColor: Colors.redAccent,
        icon: Icons.category,
        text: "category",
        textColor: Colors.white,
        secondText: product.category!,
        color: Colors.white,
        textSize: 15,
      ),
      IconTextWidgetColumn(
        backgroundColor: Colors.redAccent,
        icon: Icons.shopping_cart_outlined,
        textSize: 15,
        text: "In Stock",
        textColor: Colors.white,
        secondText: product.stock.toString(),
        color: Colors.white,
      ),
    ];
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${product.title}",
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
              TextContainer(
                text: "\$${product.price}",
                fontSize: 18,
                backgroundColor: Colors.redAccent,
              ),
            ],
          ),
          const Text(
            "About Product",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                icons.length,
                (index) => icons[index],
              ),
            ),
          ),
          const Text(
            "Description",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Text(
            "${product.description}",
            style: const TextStyle(
              color: Color.fromARGB(255, 119, 119, 119),
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: MaterialButton(
                onPressed: () {},
                child: const Text('text'),
              )),
            ],
          )
        ],
      ),
    );
  }
}
