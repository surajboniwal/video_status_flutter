import 'package:get/get.dart';
import 'package:video_status/data/models/category.dart';
import 'package:video_status/data/repositories/category.dart';

CategoryRepo _categoryRepo = CategoryRepository();

class CategoryController extends GetxController {
  List<Category> categories = [];
  bool isLoaded = false;

  getCategories() async {
    categories = await _categoryRepo.getCategoriesFromApi();
    isLoaded = true;
    update();
  }
}
