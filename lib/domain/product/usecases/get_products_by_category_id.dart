import 'package:dartz/dartz.dart';
import 'package:online_shop/core/usecase/usecase.dart';
import 'package:online_shop/domain/product/repository/product.dart';
import 'package:online_shop/service_locator.dart';

class GetProductsByCategoryIdUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ProductRepository>().getProductsByCategoryId(params!);
  }
}
