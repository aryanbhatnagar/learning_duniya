import 'package:meta/meta.dart';

class CategorySetting {
  String title;
  bool value;

  CategorySetting({
    required this.title,
    this.value = false,
  });
}
