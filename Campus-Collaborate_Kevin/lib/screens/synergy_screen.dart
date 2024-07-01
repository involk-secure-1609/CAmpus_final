import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/routing_constants.dart';
import '../constants/themes.dart';
import '../locator.dart';
import '../widgets/course_review_container.dart';
class SynergyScreen extends StatefulWidget {
  const SynergyScreen({super.key});

  @override
  State<SynergyScreen> createState() => _CourseReviewScreen();
}

class _CourseReviewScreen extends State<SynergyScreen> {

  late final Stream<QuerySnapshot> synergy_stream;
  ScrollController scrollController = ScrollController();
  final ImageProvider imageProvider=AssetImage('assets/circular_user.png');

  @override
  void initState() {
    super.initState();
    synergy_stream = FirebaseFirestore.instance
        .collection('Synergy')
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    final UserInfo userInfo=context.read<UserProvider>().userInfo;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E1E1E), Color(0xFF333333)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.5),
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Synergy ',
                      style: TextStyle(
                        color: Themes.getColors(ColorsValues.ORANGE_COLOR),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black54,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      navigationService.pushScreen(Routes.profileScreen, arguments: userInfo);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: userInfo.url == null || userInfo.url!.isEmpty
                          ? imageProvider
                          : NetworkImage(userInfo.url!) as ImageProvider,
                      foregroundImage: userInfo.url == null || userInfo.url!.isEmpty
                          ? imageProvider
                          : NetworkImage(userInfo.url!),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: (){
                navigationService.pushScreen(Routes.createCourseReviewScreen);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              child: const Icon(Icons.add, color: Colors.white,),
            ),
          ),
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: synergy_stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                    {
                      return Text('');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting)
                    {
                      return const Text('');
                    }
                    return ListView(
                      shrinkWrap: true,
                      controller: scrollController, // Add this line
                      children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                        String course_review_id = data['CourseReviewId'];
                        String course_review_title=data['CourseReviewTitle'];
                        String course_review_course_name=data['CourseReviewCourseName'];
                        String course_review_content=data['CourseReviewContent'];
                        String course_review_user=data['CourseReviewSenderName'];
                        String course_review_email=data['CourseReviewSenderEmail'];
                        return CourseReviewContainer(
                          title: course_review_title,
                          course: course_review_course_name,
                          user: course_review_user,
                          id: course_review_id,
                          review: course_review_content,
                          email:course_review_email,
                        );
                      }).toList(),
                    );
                  },
                ),
              ))
            ],
          )
      ),
    );
  }
}