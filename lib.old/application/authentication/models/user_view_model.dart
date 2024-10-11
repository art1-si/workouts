import '../../../../lib/domain/entities/user.dart';

class UserViewModel {
  const UserViewModel({required this.id});

  final String id;
  factory UserViewModel.fromUser(User user) {
    return UserViewModel(id: user.id);
  }
}
