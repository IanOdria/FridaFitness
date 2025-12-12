import 'package:stacked/stacked.dart';
import 'package:fridafit/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateTo(String route) {
    _navigationService.navigateTo(route);
  }
}
