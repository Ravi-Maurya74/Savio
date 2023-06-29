import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List comments = [
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
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(widget.data['date']);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat('MM/dd/yyyy').format(inputDate);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightForFinite(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 14, left: 14, right: 14),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(37, 42, 52, 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                          title: Text(
                            "${widget.data['student']}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(outputDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14)),
                        ),
                        const Divider(
                          thickness: 0.9,
                        ),
                        Text(widget.data['title'],
                            style: Theme.of(context) // 1
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.white70)),
                        if ((widget.data['image_url'] as String).isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Image(
                              image: NetworkImage(widget.data['image_url']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        Text(
                          '${widget.data['content']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  //   child: Text(
                  //     'Comments :',
                  //     style: Theme.of(context).textTheme.headlineSmall,
                  //   ),
                  // ),
                  Padding(
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
                                padding:
                                    const EdgeInsets.fromLTRB(28, 0, 12, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${comments[index]['comment']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: const Color.fromARGB(
                                                  255, 217, 215, 215)),
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
                                              setState(() {
                                                comments[index]['upvotes']++;
                                                tap = true;
                                              });
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
                  )
                ],
              ),
            )));
  }
}
