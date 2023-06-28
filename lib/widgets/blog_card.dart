import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.title,
    required this.desc,
    required this.author,
    required this.press,
    required this.upvotes,
    this.image = '',
  });
  //required this.slug});

  final String image, title, desc, author, upvotes;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        color: Theme.of(context).cardTheme.color,
        surfaceTintColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image.isNotEmpty)
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Image.network(image, fit: BoxFit.fill)),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(title,
                      style: Theme.of(context) // 1
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: Colors.white70)),
                  const SizedBox(height: 2),
                  Text(
                    desc.length > 100
                        ? '${desc.substring(0, 100)}...'
                        : '$desc',
                    style: Theme.of(context).textTheme.bodyLarge, //2
                  ),
                  const Divider(
                    thickness: 0.9,
                  ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.account_circle,
                      size: 35,
                    ),
                    title: Text(author,
                        style: Theme.of(context) //3
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.arrow_upward,
                          size: 20,
                        ),
                        Text(upvotes),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
