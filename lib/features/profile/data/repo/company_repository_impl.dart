import 'package:injectable/injectable.dart';

import '../../domain/repo/company_repository.dart';
import '../datasource/company_datasource.dart';

@LazySingleton(as: CompanyRepository)
class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDatasource datasource;

  CompanyRepositoryImpl({required this.datasource});

  @override
  Future<String> getCompanyID() async {
    return datasource.getCompanyID();
  }
}
