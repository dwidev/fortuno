import 'package:equatable/equatable.dart';
import 'package:fortuno/features/auth/domain/enums/role_enum.dart';

class UserAccount extends Equatable {
  final String id;
  final String name;
  final String email;
  final Role role;

  const UserAccount({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, email, role];

  @override
  bool? get stringify => true;
}
