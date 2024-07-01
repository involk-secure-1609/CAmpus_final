import 'package:campuscollaborate/services/navigation_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

final navigationService = locator<NavigationService>();

void setUpLocator() {
  locator.registerSingleton(NavigationService());
}
