import 'package:campuscollaborate/constants/all_courses.dart';
import 'package:campuscollaborate/models/create_course_review.dart';
import 'package:campuscollaborate/services/course_review_services.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:campuscollaborate/widgets/commonWidgets/app_bar.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/form_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../constants/themes.dart';
import '../widgets/createProjectScreen/multi_dropdown.dart';

class NewCourseReviewScreen extends StatefulWidget {
  const NewCourseReviewScreen({super.key});

  @override
  CourseReviewState createState() => CourseReviewState();
}

class CourseReviewState extends State<NewCourseReviewScreen> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  final MultiSelectController multiSelectCourseController = MultiSelectController();

  final CourseReviewServices courseReviewServices=CourseReviewServices();
   List<String>?courseIds;


  @override
  void initState() {
    super.initState();
    for(int i=0;i<courses.length;i++)
      {
        courseIds?.add(courses[i]['code']!);
      }
  }

  @override
  void dispose() {
    super.dispose();
    textController3.dispose();
    textController2.dispose();
    textController1.dispose();
  }
  String? dropdownvalue ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar('New Course Review'),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                //   child: FormTextFieldContainer(
                //     title: "Course Code and Name",
                //     hintText: "Enter the Course Code or Name",
                //     textEditingController: textController1,
                //   ),
                // ),
                const Text(
                  'Course Code and Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                 MultipleSelectionCourseIdDropDown(multiSelectDropDown: multiSelectCourseController),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: FormTextFieldContainer(
                    title: "Review Title",
                    hintText: "Title for your review",
                    textEditingController: textController2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: FormTextFieldContainer(
                    title: "Review Description",
                    hintText: "Enter the description of the review...",
                    textEditingController: textController3,
                    maxLines: 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 15, 10, 0),
                  child: GestureDetector(
                    onTap: () async {
                      String courseId=multiSelectCourseController.selectedOptions[0].label.toString();
                      print('ye');
                      print(courseId);
                      CreateCourseReview courseReview=CreateCourseReview(
                        title: textController2.text,
                        courseName: courseId,
                        description: textController3.text,
                        userName:context.read<UserProvider>().userInfo.name,
                        email:context.read<UserProvider>().userInfo.email,
                        professor: 'Doesnt Matter',
                      );
                      textController3.clear();
                      textController2.clear();
                      textController1.clear();
                      multiSelectCourseController.clearAllSelection();
                      await courseReviewServices.createCourseReview(courseReview, context);
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(224, 140, 56, 1),
                        borderRadius: BorderRadius.circular(
                            100.0), // Set the radius to 100 pixels
                      ),
                      child: const Center(
                        child: Text(
                          'PUBLISH REVIEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}