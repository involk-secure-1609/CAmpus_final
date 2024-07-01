import 'package:campuscollaborate/models/create_synergy.dart';
import 'package:campuscollaborate/services/synergy_services.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:campuscollaborate/widgets/commonWidgets/app_bar.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/form_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCourseReviewScreen extends StatefulWidget {
  const NewCourseReviewScreen({super.key});

  @override
  CourseReviewState createState() => CourseReviewState();
}

class CourseReviewState extends State<NewCourseReviewScreen> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  final SynergyServices synergyServices=SynergyServices();


  @override
  void dispose() {
    super.dispose();
    textController2.dispose();
    textController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar('Create Synergy'),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: FormTextFieldContainer(
                    title: "Synergy Title",
                    hintText: "Title for your synergy",
                    textEditingController: textController1,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: FormTextFieldContainer(
                    title: "Synergy Description",
                    hintText: "Enter the description of your synergy",
                    textEditingController: textController2,
                    maxLines: 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 15, 10, 0),
                  child: GestureDetector(
                    onTap: () async {
                      CreateSynergy synergy=CreateSynergy(
                          title: textController1.text,
                          description: textController2.text,
                          userName: context.read<UserProvider>().userInfo.name,
                          email: context.read<UserProvider>().userInfo.email,
                      );
                      textController2.clear();
                      textController1.clear();
                      await synergyServices.createSynergy(synergy, context);
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
                          'PUBLISH SYNERGY',
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