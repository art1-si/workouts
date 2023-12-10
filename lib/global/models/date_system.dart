enum DateSystem {
  /// Follows ISO week numbering
  iso,

  /// Uses a system in which week 1 is the week (starting at Sunday) that contains Jan. 1st
  us;

  int get startDayOfWeek => switch (this) {
        iso => DateTime.monday,
        us => DateTime.sunday,
      };

  static DateSystem tryParse(String value) {
    switch (int.tryParse(value)) {
      case 1:
        return iso;
      case 7:
        return us;

      default:
        return iso;
    }
  }

  /// Globally accessible value for date system
  /// that has been loaded for the current user.
  static DateSystem forUser = DateSystem.iso;
}
