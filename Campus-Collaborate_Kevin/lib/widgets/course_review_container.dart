import 'package:flutter/material.dart';
import '../constants/routing_constants.dart';
import '../locator.dart';
import '../models/comment_model.dart';
import '../screens/course_review_comments.dart';
import 'commonWidgets/common_container.dart';
import 'commonWidgets/skills_container.dart';

class CourseReviewContainer extends StatelessWidget {
  final String title;
  final String course;
  final String review;
  final String user;
  final String id;
  final String email;

  const CourseReviewContainer({
    super.key,
    required this.title,
    required this.course,
    required this.review,
    required this.user,
    required this.id,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationService.pushScreen(Routes.viewCourseReviewCommentsScreen,
            arguments: CourseReviewComment(
                id: id, course: course, review: review, email: email, title: title, user: user));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          color: const Color(0xFF333333), // Darker background for card
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkillContainer(skill: course),
                const SizedBox(height: 12),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/circular_user.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      user,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  review,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'comments',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.comment,
                      color: Colors.white70,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
