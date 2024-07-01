import 'package:campuscollaborate/chats/dmmessages.dart';
import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:campuscollaborate/services/user_services.dart';
import 'package:campuscollaborate/widgets/commonWidgets/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../chats/database_provider.dart';
import '../services/roll_number_decoder.dart';
import '../widgets/commonWidgets/app_bar.dart';
import '../widgets/commonWidgets/common_container.dart';
import '../widgets/commonWidgets/common_elevated_button.dart';
import '../widgets/commonWidgets/skills_container.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final UserInfo userInfo;
  const OtherUserProfileScreen({super.key, required this.userInfo});

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  @override
  DatabaseProvider databaseProvider = DatabaseProvider();

  Widget build(BuildContext context) {
    final RollNumberDecoder rollNumberDecoder =
        RollNumberDecoder(rollNumber: int.parse(widget.userInfo.rollNumber));
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: customAppBar('Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.userInfo.program,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async{
                        final UserInfo myUserInfo=context.read<UserProvider>().userInfo;
                        String email1=myUserInfo.email;
                        String email2=widget.userInfo.email;
                        String chatId=email1+email2;
                        FirebaseFirestore.instance
                            .collection('DmConversations')
                            .doc(chatId).set({
                          'user1':myUserInfo.email,
                          'user2':widget.userInfo.email,
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DmMessageScreen(groupId: chatId, myInfo: myUserInfo, oppInfo: widget.userInfo,)
                          ),
                        );
                        // Handle the action when the three dots icon is pressed
                        print('Three dots icon pressed');
                      },
                      // onTap: ()async {
                      //   final UserInfo myUserInfo=context.read<UserProvider>().userInfo;
                      //   String email1=myUserInfo.email;
                      //   String email2=widget.userInfo.email;
                      //   String chatId=email1+email2;
                      //    FirebaseFirestore.instance
                      //       .collection('DmConversations')
                      //       .doc(chatId).set({
                      //      'user1':myUserInfo.email,
                      //      'user2':widget.userInfo.email,
                      //    });
                      //    Navigator.push(DmMessageScreen(groupId: chatId, myInfo: myUserInfo, oppInfo: widget.userInfo,));
                      // },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/chat_bubble.png',
                            width: 33.53,
                            height: 34.71,
                          ),
                          const Text(
                            'Message',
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
                  SkillListWithoutButton(skillsList: widget.userInfo.skills),
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
                      'Projects',
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

class ProfileScreenSplash extends StatefulWidget {
  final String userId;
  const ProfileScreenSplash({super.key, required this.userId});

  @override
  State<ProfileScreenSplash> createState() => _ProfileScreenSplashState();
}

class _ProfileScreenSplashState extends State<ProfileScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('id here');
    print(widget.userId);
    fetchDetails();
  }
  Future<void> fetchDetails()async{
    final UserInfo userInfo= await UserServices().getUserById(widget.userId);
    print('in splash');
    print(userInfo.name);
    navigationService.pushReplacementScreen(Routes.otherUserProfileScreen, arguments: userInfo);
  }
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
      body: Center(
        child: Text('Fetching Data, Please wait...'),
      ),
    ),);
  }
}

