import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/screens/edit_profile.dart';
import 'package:campuscollaborate/services/roll_number_decoder.dart';
import 'package:campuscollaborate/widgets/commonWidgets/app_bar.dart';
import 'package:campuscollaborate/widgets/commonWidgets/common_container.dart';
import 'package:campuscollaborate/widgets/commonWidgets/common_elevated_button.dart';
import 'package:campuscollaborate/widgets/commonWidgets/skills_container.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final UserInfo userInfo;
  const ProfileScreen({super.key, required this.userInfo});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final RollNumberDecoder rollNumberDecoder =
        RollNumberDecoder(rollNumber: int.parse(widget.userInfo.rollNumber));
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: customAppBar('Profile', vertRequired: true),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 9, right: 9, top: 10, bottom: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        widget.userInfo.url != null&&widget.userInfo.url!.isNotEmpty?
                        ClipOval(
                          child: Image.network(widget.userInfo.url!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ) : const Icon(
                          Icons.supervised_user_circle,
                          size: 90,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userInfo.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              widget.userInfo.rollNumber,
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              rollNumberDecoder.getBranch(),
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.visible,
                            ),
                            Text(
                              widget.userInfo.program,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> EditProfile(userDetails:widget.userInfo,)),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/edit_profile.png',
                            width: 33.53,
                            height: 34.71,
                          ),
                          const Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonContainer(children: [
                  const Text(
                    'Skills',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SkillsListView(skillsList: widget.userInfo.skills),
                ]),
                const SizedBox(
                  height: 20,
                ),
                CommonContainer(children: [
                  const Text(
                    'Courses',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CourseContainerListView(coursesList: widget.userInfo.courses),
                ]),
                const SizedBox(
                  height: 20,
                ),
                CommonGesturizedButton(
                    onPressed: () {
                      navigationService.pushScreen(Routes.projectListScreen, arguments: widget.userInfo.projects);
                    },
                    buttonText: const Text(
                      'My Projects',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 20,
                ),
                CommonGesturizedButton(
                    onPressed: () {
                      navigationService.pushScreen(Routes.savedProjectListScreen, arguments: widget.userInfo.starBy);
                    },
                    buttonText: const Text(
                      'Saved Projects',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
