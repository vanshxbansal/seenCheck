import 'package:hive/hive.dart';

part 'image_feed.g.dart';

@HiveType(typeId: 1)
class ImageFeed extends HiveObject {
  @HiveField(0)
  final String imageName;

  @HiveField(1)
  final String title;

  ImageFeed({required this.imageName, required this.title});
}
