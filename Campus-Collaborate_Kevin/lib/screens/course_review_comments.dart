import 'package:campuscollaborate/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../chats/comment_model.dart';
import '../chats/database_provider.dart';
import '../widgets/commonWidgets/app_bar.dart';
import '../widgets/commonWidgets/common_container.dart';
import '../widgets/commonWidgets/skills_container.dart';

class CourseReviewComments extends StatefulWidget {
 final CourseReviewComment comment;

  const CourseReviewComments(
      {super.key,
       required this.comment});

  @override
  State<CourseReviewComments> createState() => _CourseReviewComments();
}

class _CourseReviewComments extends State<CourseReviewComments> {
  late final Stream<QuerySnapshot> comment_stream;
  late final String review_title;
  late final String review_course;
  late final String review_message;
  late final String review_user;

  @override
  void initState() {
    super.initState();
    comment_stream = FirebaseFirestore.instance
        .collection('CourseReviewss')
        .doc(widget.comment.id)
        .collection('comments')
        .snapshots();
    review_course = widget.comment.course;
    review_message = widget.comment.review;
    review_title = widget.comment.title;
    review_user = widget.comment.user;
  }
  DatabaseProvider databaseProvider = DatabaseProvider();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar('Review Comments'),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Course Code',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                SkillContainer(
                  skill: review_course,
                  fontSize: 12,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Review Title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  review_title.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(224, 140, 56, 1),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Reviewer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image.asset(
                      'assets/circular_user.png',
                      height: 15,
                      width: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      review_user,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(240, 238, 238, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Review',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white), // White border
                  ),
                  padding: const EdgeInsets.all(8.0),
                  // Padding for spacing between text and border
                  child: Text(
                    review_message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Comments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: comment_stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return ListView(
                      shrinkWrap: true,
                      controller: scrollController, // Add this line
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonContainer(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/circular_user.png',
                                      height: 15,
                                      width: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data['senderId'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(238, 238, 238, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  data['comment'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(238, 238, 238, 1),
                                  ),
                                )
                              ],
                            ));
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(85, 85, 85, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Add Comments',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: textController,
                          maxLines: 10,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Type here...',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        ElevatedButton(
                          onPressed: () async {
                            String comment =textController.text;
                            textController.clear();
                            Comment comment1=Comment(
                              comment:comment,
                              senderId:widget.comment.user,
                            );
                            await databaseProvider.sendComments(widget.comment.id, false, comment1);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Send Comment',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}
