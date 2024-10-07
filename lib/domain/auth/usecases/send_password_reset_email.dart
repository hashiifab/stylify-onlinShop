import 'package:dartz/dartz.dart';
import 'package:online_shop/core/usecase/usecase.dart';
import 'package:online_shop/domain/auth/repository/auth.dart';
import 'package:online_shop/service_locator.dart';

class SendPasswordResetEmailUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return sl<AuthRepository>().sendPasswordResetEmail(params!);
  }
}
