import 'package:exp_man/providers/community_post.dart';
import 'package:exp_man/screens/blogscreen.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({super.key, required this.receivedData});

  final dynamic receivedData;

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  late CommunityPost communityPost;

  @override
  void initState() {
    super.initState();
    communityPost = CommunityPost.fromJson(widget.receivedData);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var result = await Navigator.pushNamed(context, BlogScreen.routeName,
            arguments: communityPost);
        if (result != null) {
          setState(() {
            communityPost = (result as CommunityPost);
          });
        }
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        color: Theme.of(context).cardTheme.color,
        surfaceTintColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (communityPost.image_url.isNotEmpty)
              Container(
                  // padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child:
                      Image.network(communityPost.image_url, fit: BoxFit.fill)),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(communityPost.title,
                      style: Theme.of(context) // 1
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: Colors.white70)),
                  const SizedBox(height: 2),
                  Text(
                    communityPost.content.length > 100
                        ? '${communityPost.content.substring(0, 100)}...'
                        : communityPost.content,
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
                    title: Text(communityPost.student,
                        style: Theme.of(context) //3
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    trailing: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            size: 20,
                            color:
                                communityPost.liked ? Colors.pink : Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(communityPost.upvotes.toString()),
                        ],
                      ),
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
