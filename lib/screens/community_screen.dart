import 'package:animations/animations.dart';
import 'package:exp_man/providers/student.dart';
import 'package:exp_man/screens/add_community_post.dart';
import 'package:exp_man/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:exp_man/widgets/blog_card.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'blogscreen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isLoading = true;
  List<dynamic> data = [];
  String Selectedvalue = 'Lucknow';

  List<String> a = ['Lucknow', 'Agartala', 'Bhubaneshwar'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initialise(context);
    });
  }

  void initialise(BuildContext context) async {
    var id = Provider.of<Student>(context, listen: false).id;
    Response response = await NetworkHelper().getData('communityPost/list/$id');
    setState(() {
      data = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        openBuilder: (context, action) => const AddCommunityPostScreen(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                if (data[index]['image_url'] == null) {
                  data[index]['image_url'] = '';
                }
                return BlogCard(
                  image: data[index]['image_url'],
                  title: data[index]['title'],
                  desc: data[index]['content'],
                  author: data[index]['student'],
                  upvotes: data[index]['upvotes'].toString(),
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogScreen(data: data[index]),
                        ));
                  },
                );
              },
              itemCount: data.length,
            )),
          ],
        ),
      ),
    );
  }
}
