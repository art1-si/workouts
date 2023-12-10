import 'package:workouts/data/authentication/models/user.dart';

class UserViewModel {
  const UserViewModel({required this.id});

  final String id;
  factory UserViewModel.fromUser(User user) {
    return UserViewModel(id: user.id);
  }
}
