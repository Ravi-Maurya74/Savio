import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Wishlist_Item(
          url:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt4WR0XQSRCzTVmmEMykTz3jMrON6meu8z1Q&usqp=CAU",
          title: "MacBook Air Pro",
          price: 116000,
        ),
        Wishlist_Item(
          url:
              "https://cdn.shopify.com/s/files/1/0586/3270/0077/files/PC3_2160x.jpg?v=1680179072",
          title: "Nothing Phone 1",
          price: 50000,
        ),
        Wishlist_Item(
          url:
              "https://www.apple.com/v/apple-watch-series-8/c/images/meta/gps-lte__gi7uzrvkt5e2_og.png",
          title: "Watch Series 8",
          price: 75000,
        )
      ],
    );
  }
}

class Wishlist_Item extends StatelessWidget {
  const Wishlist_Item({this.url, this.title, this.price});

  final String? url, title;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: NetworkImage(url.toString()),
                  fit: BoxFit.fill,
                ),
              ),
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
                const SizedBox(height: 10.0),
                Container(
                  height: 1,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width *
                      0.40, // 75% of the screen width
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "₹ $price",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
