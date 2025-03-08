import 'package:fortuno/core/environtments/env_enum.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDepedencies({required Environtment environment}) =>
    getIt.init(environment: environment.name);
