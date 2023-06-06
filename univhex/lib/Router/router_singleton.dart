import 'package:univhex/Router/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<AppRouter>(AppRouter());
}
