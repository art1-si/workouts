import 'package:workouts/domain/entities/user.dart';

abstract interface class UserRepository {
  /// Returns the current user's profile.
  Future<User> getUserInfo();
}
