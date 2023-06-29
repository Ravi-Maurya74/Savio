import 'package:flutter/material.dart';
import 'package:exp_man/widgets/custom_appbar.dart';

class AddWishlistScreen extends StatefulWidget {
  const AddWishlistScreen({super.key});

  @override
  State<AddWishlistScreen> createState() => _AddWishlistScreenState();
}

class _AddWishlistScreenState extends State<AddWishlistScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _urlController = TextEditingController();
  bool initialValue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomAppbar(
                title: 'Add Item to Wishlist',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      textCapitalization: TextCapitalization.sentences,
                      controller: _titleController,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This feild  is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This feild  is required';
                        } else if (double.tryParse(_amountController.text)! <
                            0) {
                          return 'Enter valid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: initialValue,
                            controller: _urlController,
                            decoration: const InputDecoration(
                              label: Text('Image url'),
                            ),
                            validator: (value) {
                              if (initialValue) {
                                if (value!.isEmpty) {
                                  return 'jab kuch bharna nhi tha tab switch on hi kyu kiye';
                                }
                                return null;
                              }
                              return null;
                            }, //this is wow
                          ),
                        ),
                        const SizedBox(width: 26),
                        Switch(
                          activeColor: const Color(0xFFd988a1),
                          value: initialValue,
                          onChanged: (value) {
                            setState(() {
                              initialValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 77, 83, 163),
                        ),
                        onPressed: () async {
                          //   bool isValid = _formKey.currentState!.validate();
                          //   if (isValid) {
                          //     Student student =
                          //         Provider.of<Student>(context, listen: false);
                          //     Response response = await NetworkHelper().postData(
                          //         url: 'communityPost/create/',
                          //         jsonMap: {
                          //           "student": student.id,
                          //           "title": _titleController.text,
                          //           "amount": _amountController.text
                          //         });
                          //     if (response.statusCode == 201) {
                          //       await showDialog(
                          //         context: context,
                          //         builder: (context) => AlertDialog(
                          //           title: const Text('Post added successfully'),
                          //           content: const Text(
                          //               "Visit community page to see added post"),
                          //           actions: [
                          //             TextButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context);
                          //               },
                          //               child: const Text('Okay'),
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //       Navigator.pop(context);
                          //     }
                          //   } else {
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) => AlertDialog(
                          //         title: const Text('Invalid Input'),
                          //         content: const Text(
                          //             "Make sure to enter all the required fields"),
                          //         actions: [
                          //           TextButton(
                          //             onPressed: () {
                          //               Navigator.pop(context);
                          //             },
                          //             child: const Text('Okay'),
                          //           )
                          //         ],
                          //       ),
                          //     );
                          //   }
                        },
                        child: const Text('Add'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
