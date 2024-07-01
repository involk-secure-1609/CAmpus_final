import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/constants/themes.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/services/contributor_search_screen_service.dart';
import 'package:campuscollaborate/services/user_services.dart';
import 'package:campuscollaborate/widgets/commonWidgets/common_container.dart';
import 'package:campuscollaborate/widgets/commonWidgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectable_list/selectable_list.dart';

import '../models/admin.dart';

class ContributorSearchScreen extends StatelessWidget {
  const ContributorSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final UserServices userServices = UserServices();
    return SafeArea(child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CommonTextField(
                      textEditingController: searchController, hintText: 'Search the user name...', suffix: const Icon(Icons.search, color: Colors.white,),
                    onTap: ()async{
                      context.read<ContributorSearchScreenService>().setSearchingAsTrue();
                      final fetchedList= await userServices.getSearchedUsers(searchController.text);
                      context.read<ContributorSearchScreenService>().setSearchedUsers(fetchedList);
                    },
                     onChanged: (value){
                      context.read<ContributorSearchScreenService>().setSearchingAsFalse();
                      context.read<ContributorSearchScreenService>().clearFetchedDataList();
                      context.read<ContributorSearchScreenService>().setDataFetchedAsFalse();
                     },
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      navigationService.pop();
                    },
                    child: Icon(Icons.check_circle, color: Themes.getColors(ColorsValues.ORANGE_COLOR), size: 35,),)
                ],
              ),
              Consumer<ContributorSearchScreenService>(
                builder: (context, service, child){
                  if(!service.searchClicked)
                  {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 250,),
                        Center(child: Text('Search for the contributors'),),
                      ],
                    );
                  }
                  else if(!service.dataFetched){
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 250,),
                        Center(child: Text('Searching For the users'),),
                      ],
                    );
                  }
                  else{
                    return Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 15,),
                          SelectableList<Admin, Admin?>(
                            items: service.searchedUsers,
                            selectedValue: service.selectedAdmin,
                            onItemSelected: (admin){
                              print('on contributor screen');
                              print(admin.id);
                              service.setSelectedAdmin(admin);
                              service.addSelectedAdmin(admin);
                            },
                            onItemDeselected: (admin){
                              service.unselectAdmin(admin);
                              service.removeSelectedAdmin(admin);
                            },
                            itemBuilder: (context, admin, selected, onTap){
                              return GestureDetector(
                                onTap: onTap,
                                  child: Column(
                                    children: [
                                      CommonContainer(
                                        color: selected?Themes.getColors(ColorsValues.ORANGE_COLOR):Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                                        children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            admin.url==null||admin.url!.isEmpty?const CircleAvatar(backgroundImage: AssetImage('assets/circular_user.png'),
                                              foregroundImage:  AssetImage('assets/circular_user.png'),
                                            ):CircleAvatar(backgroundImage: NetworkImage(admin.url!),),
                                            const SizedBox(width: 10),
                                            Text(admin.name, style: const TextStyle(fontSize: 13),)
                                          ],
                                        ),
                                      ],),
                                      const SizedBox(height: 15,)
                                    ],
                                  )
                              );
                            },
                          ),
                        ],
                      )
                    );
                  }
                },
              ),
            ],
          ),
        ),
    ));
  }
}
