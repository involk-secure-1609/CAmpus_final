import 'dart:io';

import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/widgets/commonWidgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_provider.dart';
import 'message_model.dart';

class DmMessageScreen extends StatefulWidget {
  final String groupId;
  final UserInfo myInfo;
  final UserInfo oppInfo;

  DmMessageScreen({super.key, required this.groupId, required this.myInfo, required this.oppInfo, });

  @override
  _DmMessageScreen createState() => _DmMessageScreen();
}

class _DmMessageScreen extends State<DmMessageScreen> {
  late final Stream<QuerySnapshot> messageStream;
  late final UserInfo oppUserInfo;
  late final UserInfo myUserInfo;
  late final String groupid;

  @override
  void initState() {
    super.initState();
    oppUserInfo = widget.oppInfo;
    myUserInfo=widget.myInfo;
    groupid = widget.groupId;
    messageStream = FirebaseFirestore.instance
        .collection('DmConversations')
        .doc(widget.groupId)
        .collection('messages')
        .orderBy('timeSent', descending: true)
        .snapshots();
  }

  DatabaseProvider databaseProvider = DatabaseProvider();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final ImageProvider imageProvider=AssetImage('assets/circular_user.png');
    return Scaffold(
      appBar: customAppBar(widget.oppInfo.name, action: Row(
        children: [
          const SizedBox(width: 5,),
          CircleAvatar(radius: 20,
            backgroundImage: widget.oppInfo.url == null||widget.oppInfo.url!.isEmpty?imageProvider:NetworkImage(widget.oppInfo.url!),
            foregroundImage: widget.oppInfo.url == null||widget.oppInfo.url!.isEmpty?imageProvider:NetworkImage(widget.oppInfo.url!),
          ),
          const SizedBox(width: 5,),
        ],
      ),),
      body: Column(
        children: [
          Expanded(
            child: messageStream==null?const SizedBox(height: 0,):Container(
              child: StreamBuilder<QuerySnapshot>
                (
                stream: messageStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('');
                  }
                  return ListView(
                    reverse: true,
                    shrinkWrap: true,
                    controller: scrollController, // Add this line
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      bool isCurrentUser = data['senderId'] == myUserInfo.email;
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Material(
                          color:isCurrentUser? Color.fromRGBO(85, 85, 85, 1):Colors.blueGrey,
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: isCurrentUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                data['image'].isNotEmpty
                                    ? SizedBox(
                                  width: double.infinity,
                                  child: AspectRatio(
                                    aspectRatio: 1, // Adjust the aspect ratio as needed
                                    child: Image.network(
                                      data['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : Text(
                                  data['message'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    ImagePicker picker = ImagePicker();
                    XFile? file =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (file != Null) {
                      String? path = file?.path;
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference image_reference = referenceRoot.child('images');
                      Reference image_to_upload = image_reference.child(path!);

                      try {
                        await image_to_upload.putFile(File(file!.path));
                        imageUrl = await image_to_upload.getDownloadURL();
                        String groupId = groupid;
                        bool isGroup = false;
                        String msg = textController.text;
                        textController.clear();
                        Message message = Message(
                            message: msg,
                            timeSent: DateTime.timestamp(),
                            senderId: myUserInfo.email,
                            image: imageUrl);
                        imageUrl='';
                        await databaseProvider.sendMessage(
                            groupId, isGroup, message);
                        await FirebaseFirestore.instance
                            .collection('DmConversations')
                            .doc(groupId)
                            .update({
                          'lastMessage': "Image",
                          'lastTime': DateTime.timestamp(),
                          'lastSender': "user1",
                        });
                        await scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 100),
                        );
                      } catch (error) {
                        print("error occured");
                      }
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 161, 93, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.photo,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Material(
                    color: Color.fromRGBO(85, 85, 85, 1),
                    borderRadius: BorderRadius.circular(20.0),
                    // Adjust the radius as needed
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      // Same radius as Material's borderRadius
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 0, 2),
                        child: TextField(
                          controller: textController,
                          autofocus: true,
                          decoration: const InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(170, 170, 170, 1)),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    String groupId = groupid;
                    bool isGroup = false;
                    String msg = textController.text;
                    textController.clear();
                    if(msg!="")
                      {
                        Message message = Message(
                            message: msg,
                            timeSent: DateTime.timestamp(),
                            senderId: myUserInfo.email,
                            image: imageUrl);
                        await databaseProvider.sendMessage(
                            groupId, isGroup, message);
                        await FirebaseFirestore.instance
                            .collection('DmConversations')
                            .doc(groupId)
                            .update({
                          'lastMessage': msg,
                          'lastTime': DateTime.timestamp(),
                          'lastSender': "user1",
                        });
                        await scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 100),
                        );
                      }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 161, 93, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
