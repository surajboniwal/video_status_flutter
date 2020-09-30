import 'package:http/http.dart';
import 'package:video_status/data/global/api_constants.dart';
import 'package:video_status/data/models/category.dart';

abstract class CategoryRepo {
  Future<List<Category>> getCategoriesFromApi();
}

class CategoryRepository implements CategoryRepo {
  @override
  Future<List<Category>> getCategoriesFromApi() async {
    Response response = await get(ApiConstants.CATEGORY_NODE);
    return categoryFromJson(response.body);
  }
}
