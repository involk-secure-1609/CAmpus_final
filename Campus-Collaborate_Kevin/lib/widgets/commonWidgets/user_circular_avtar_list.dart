import 'package:flutter/material.dart';

import '../../models/admin.dart';

class UserCircularAvatars extends StatelessWidget {
  final List<Admin> admins;
  const UserCircularAvatars({super.key, required this.admins});
  @override
  Widget build(BuildContext context) {
    const ImageProvider imageProvider= AssetImage('assets/circular_user.png');
    return SizedBox(
      height: 30,
      width: 70,
      child: Stack(
          children: List.generate(admins.length, (index) {
        return Positioned(
            left: index * 15,
            child: CircleAvatar(
              backgroundImage: admins[index].url == null||admins[index].url!.isEmpty
                  ? imageProvider
                  : NetworkImage(admins[index].url!),
              radius: 15,
            ));
      })),
    );
  }
}
