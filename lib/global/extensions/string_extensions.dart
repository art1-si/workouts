extension TransformString on String {
  String get initials {
    if (isEmpty) return this;
    final items = trim().split(' ');

    final initials = switch (items.length) {
      1 => items[0].substring(0, 1),
      _ => items[0].substring(0, 1) + items[items.length - 1].substring(0, 1)
    };
    return initials;
  }

  String get capitalize => switch (length) {
        0 => this,
        1 => toUpperCase(),
        _ => this[0].toUpperCase() + substring(1).toLowerCase(),
      };
}
