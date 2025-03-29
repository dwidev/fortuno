import 'package:injectable/injectable.dart';

import '../../domain/repo/company_repository.dart';
import '../datasource/company_datasource.dart';

@LazySingleton(as: CompanyRepository)
class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDatasource datasource;

  String _companyID = '';

  CompanyRepositoryImpl({required this.datasource});

  @override
  Future<String> getCompanyID() async {
    if (_companyID.isNotEmpty) return _companyID;

    final companyId = await datasource.getCompanyID();
    _companyID = companyId;
    return companyId;
  }
}
