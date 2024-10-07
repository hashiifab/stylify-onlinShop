import 'package:dartz/dartz.dart';
import 'package:online_shop/core/usecase/usecase.dart';
import 'package:online_shop/domain/auth/repository/auth.dart';
import 'package:online_shop/service_locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
