import 'package:equatable/equatable.dart';
import 'package:tutor4you/core/usecase/usecase.dart';
import 'package:tutor4you/core/utils/typedef.dart';
import 'package:tutor4you/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;

  const CreateUser(this._repository);

  @override
  ResultVoid call(CreateUserParams params) => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
          createdAt: '_empty.createAt',
          name: '_empty.name',
          avatar: '_empty.avar',
        );

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
