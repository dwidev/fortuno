import 'package:fortuno/core/failures/failure.dart';

abstract class CompanyFailure extends Failure {
  CompanyFailure(super.message);
}

class NotFoundCompanyID extends CompanyFailure {
  NotFoundCompanyID()
    : super("Perusahaan tidak ditemukan, silahkan login kembali");
}
