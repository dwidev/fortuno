import '../../domain/failures/company_failure.dart';

import '../../../../core/local_storage/local_storage.dart';
import '../../../auth/domain/entities/user_authenticated.dart';
import 'company_datasource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CompanyDatasource)
class CompanyLocalDatasource implements CompanyDatasource {
  final ILocalStorage preference;

  CompanyLocalDatasource({@sharedPref required this.preference});

  @override
  Future<String> getCompanyID() async {
    final result = await preference.getData(companyIdKey);
    final companyId = result as String?;

    if (companyId == null || companyId.isEmpty) {
      throw NotFoundCompanyID();
    }

    return companyId;
  }
}
