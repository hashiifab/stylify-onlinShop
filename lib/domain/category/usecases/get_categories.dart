import 'package:dartz/dartz.dart';
import 'package:online_shop/core/usecase/usecase.dart';
import 'package:online_shop/domain/category/repository/category.dart';
import 'package:online_shop/service_locator.dart';

class GetCategoriesUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<CategoryRepository>().getCategories();
  }
}
