import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../environments/env_enum.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDepedencies({required EnvApp env}) async =>
    getIt.init(environment: env.name);
