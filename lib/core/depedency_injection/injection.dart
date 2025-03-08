import 'package:fortuno/core/environments/env_enum.dart';
import 'package:fortuno/core/environments/env_enum.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDepedencies({required EnvApp env}) =>
    getIt.init(environment: env.name);
