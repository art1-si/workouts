/// God mode mixin. This mixin is used to enable god mode.
/// God mode is a mode that allows user to bypass some restrictions, or see more details when error happens.
///
/// God mode is used for debugging purposes and normal user shouldn't have access to it.
mixin GodModeMixin {
  bool get godMode => true;
}
