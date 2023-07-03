import 'package:exp_man/screens/add_wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('wishlist rebuild');
    return Scaffold(
      floatingActionButton: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: const CircleBorder(),
        closedColor: const Color(0xFF50559a),
        openColor: Theme.of(context)
            .scaffoldBackgroundColor, //const Color(0xFF16161e),
        middleColor: const Color(0xFFd988a1),
        closedBuilder: (context, action) => Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF50559a),
          ),
          child: const Icon(
            Icons.add,
            size: 25,
            color: Color.fromARGB(255, 216, 216, 216),
          ),
        ),
        openBuilder: (context, action) => const AddWishlistScreen(),
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 10,
          ),
          WishlistItem(
            url:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt4WR0XQSRCzTVmmEMykTz3jMrON6meu8z1Q&usqp=CAU",
            title: "MacBook Air Pro",
            price: 116000,
          ),
          WishlistItem(
            url:
                "https://cdn.shopify.com/s/files/1/0586/3270/0077/files/PC3_2160x.jpg?v=1680179072",
            title: "Nothing Phone 1",
            price: 50000,
          ),
          WishlistItem(
            url:
                "https://www.apple.com/v/apple-watch-series-8/c/images/meta/gps-lte__gi7uzrvkt5e2_og.png",
            title: "Watch Series 8",
            price: 75000,
          ),
        ],
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  const WishlistItem({super.key,this.url, this.title, this.price});

  final String? url, title;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.0,
              width: 140.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: NetworkImage(url.toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toString(),
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    // fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3.0),
                // const Divider(
                //   thickness: 0.9,
                //   indent: 5,
                //   endIndent: 10,
                // ),
                Text(
                  "₹ $price",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ));
  }
}
