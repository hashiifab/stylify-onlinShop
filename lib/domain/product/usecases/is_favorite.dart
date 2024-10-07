import 'package:online_shop/core/usecase/usecase.dart';
import 'package:online_shop/domain/product/repository/product.dart';
import 'package:online_shop/service_locator.dart';

class IsFavoriteUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<ProductRepository>().isFavorite(params!);
  }
}
