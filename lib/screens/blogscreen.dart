import 'package:exp_man/providers/community_post.dart';
import 'package:exp_man/providers/student.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';

class BlogScreen extends StatelessWidget {
  static const routeName = '/blogscreen';
  const BlogScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(
            context, Provider.of<CommunityPost>(context, listen: false));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightForFinite(),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Post(),
                Comments(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({
    super.key,
  });

    final List comments = const [
    {
      "student": "Ravi Maurya",
      "comment":
          "Dear friend, Thank you for offering to sell me an electric kettle. I appreciate your thoughtfulness and the opportunity to buy from you. Unfortunately, I won’t be able to buy the kettle from you at this time. The reason is that I already have a kettle that is still working well and I don’t need a new one right now. I hope you understand my situation and that this doesn’t affect our friendship. Thank you again for thinking of me and offering to sell me the kettle. Best regards, Ravi Maurya",
      "upvotes": 0,
      "date": "2023-06-25",
      "post": 2,
      "liked": false
    },
    {
      "student": "Akshaj Pal",
      "comment":
          "Dear friend, Thank you for offering to sell me an electric kettle. I am thrilled to hear about this opportunity and would love to buy it from you. I have been looking for a new kettle for some time now and your offer couldn’t have come at a better time. I trust your judgment and know that the kettle you’re selling must be of good quality. Please let me know the details of the kettle and how I can make the payment. I am looking forward to using my new electric kettle and am grateful to you for offering to sell it to me. Best regards, Akshaj Pal",
      "upvotes": 0,
      "date": "2023-06-25",
      "post": 2,
      "liked": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          bool tap = false;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${comments[index]['student']}',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${comments[index]['comment']}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color.fromARGB(255, 217, 215, 215)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Spacer(),
                          Text('${comments[index]['upvotes']}'),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (tap == false) {
                                // setState(() {
                                //   comments[index]['upvotes']++;
                                //   tap = true;
                                // });
                              }
                            },
                            child: Icon(
                              tap
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              size: 15.0,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const Divider(
                thickness: 0.9,
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CommunityPost communityPost =
        Provider.of<CommunityPost>(context, listen: false);
    DateTime parseDate = communityPost.date;
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat('dd/MM/yyyy').format(inputDate);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(top: 10, bottom: 14, left: 14, right: 14),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(37, 42, 52, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.account_circle,
              size: 30,
            ),
            title: Text(
              communityPost.student,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: Text(outputDate,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 14)),
          ),
          const Divider(
            thickness: 0.9,
          ),
          Text(communityPost.title,
              style: Theme.of(context) // 1
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.white70)),
          if (communityPost.image_url.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image(
                image: NetworkImage(communityPost.image_url),
                fit: BoxFit.cover,
              ),
            ),
          Text(
            communityPost.content,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
          ),
          const Activity()
        ],
      ),
    );
  }
}

class Activity extends StatelessWidget {
  const Activity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CommunityPost communityPost = Provider.of<CommunityPost>(context);
    return Row(
      children: [
        const Spacer(),
        IconButton(
            onPressed: () {
              communityPost.toggleBookMark(
                  Provider.of<Student>(context, listen: false).id);
            },
            icon: communityPost.bookmarked
                ? const Icon(Icons.bookmark_add)
                : const Icon(Icons.bookmark_add_outlined)),
        LikeButton(
          likeBuilder: (isLiked) => Icon(
            Icons.arrow_upward,
            color: isLiked ? Colors.pink : Colors.grey,
          ),
          likeCount: communityPost.upvotes,
          isLiked: communityPost.liked,
          onTap: (isLiked) {
            communityPost
                .toggleLike(Provider.of<Student>(context, listen: false).id);
            return Future.value(!isLiked);
          },
        ),
      ],
    );
  }
}
