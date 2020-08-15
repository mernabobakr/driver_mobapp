import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

setupLocators() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  getIt.registerSingleton(preferences);
}
