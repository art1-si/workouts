import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> registerDependencies() async {
  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPref);
}
