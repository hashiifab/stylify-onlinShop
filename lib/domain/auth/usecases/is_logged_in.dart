import 'package:online_shop/core/usecase/usecase.dart';
import 'package:online_shop/domain/auth/repository/auth.dart';
import 'package:online_shop/service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}
