import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/constants/themes.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/admin.dart';
import 'package:flutter/material.dart';

class ContributorContainer extends StatelessWidget {
  final Admin contributor;
  final double? fontSize;
  const ContributorContainer(
      {super.key, required this.contributor, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('inside contributor');
        print(contributor.id);
        navigationService.pushScreen(Routes.otherUserProfileSplashScreen, arguments: contributor.id);
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
              radius: 12,
              child: contributor.url == null||contributor.url!.isEmpty
                  ? Image.asset('assets/circular_user.png')
                  : Image.network(
                      contributor.url!,
                      height: 20,
                      width: 20,
                    ),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                contributor.name,
                style: TextStyle(
                    fontSize: fontSize ?? 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContributorListView extends StatelessWidget {
  final List<Admin> contributorsList;
  const ContributorListView({super.key, required this.contributorsList});

  @override
  Widget build(BuildContext context) {
    if (contributorsList.length <= 5) {
      return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: contributorsList.map((contributor) {
            return ContributorContainer(
              contributor: contributor,
            );
          }).toList());
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: contributorsList.take(4).map((contributor) {
              return ContributorContainer(
                contributor: contributor,
              );
            }).toList()),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 5)),
            child: Text(
              '+${contributorsList.length - 4} More',
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }
}
