import 'package:hive/hive.dart';

part 'login_data.g.dart';

@HiveType(typeId: 0)
class LoginData extends HiveObject {
  @HiveField(0)
  late String email;

  @HiveField(1)
  late bool isActive;

  LoginData({required this.email, required this.isActive});
}
