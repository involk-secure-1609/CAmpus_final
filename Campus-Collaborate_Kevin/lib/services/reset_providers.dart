import 'package:campuscollaborate/services/contributor_search_screen_service.dart';
import 'package:campuscollaborate/services/docs_and_images.dart';
import 'package:campuscollaborate/services/drop_down_services.dart';
import 'package:campuscollaborate/services/toggle_button_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ResetProviders{
  static void reset(BuildContext context){
    Provider.of<ContributorSearchScreenService>(context, listen: false).clearAllProviders();
    Provider.of<DocsStateService>(context, listen: false).resetProvider();
    Provider.of<ProjectImageStateService>(context, listen: false).resetProvider();
    Provider.of<DropDownServices>(context, listen: false).resetProvider();
    Provider.of<ProjectTypeToggleButtonService>(context, listen: false).resetProvider();
    Provider.of<ProjectStatusToggleButtonService>(context, listen: false).resetProvider();
  }
}