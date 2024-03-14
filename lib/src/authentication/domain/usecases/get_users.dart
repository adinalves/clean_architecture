import 'package:tutor4you/core/usecase/usecase.dart';
import 'package:tutor4you/core/utils/typedef.dart';
import 'package:tutor4you/src/authentication/domain/entities/user.dart';
import 'package:tutor4you/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  final AuthenticationRepository _repository;

  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() => _repository.getUsers();
}
