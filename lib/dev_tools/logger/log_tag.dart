enum LogTag {
  widget(displayableNameCapitalized: 'WIDGET'),
  caster(displayableNameCapitalized: 'CASTER'),
  router(displayableNameCapitalized: 'ROUTER'),
  exerciseSelector(displayableNameCapitalized: 'EXERCISE SELECTOR'),
  ;

  const LogTag({
    required this.displayableNameCapitalized,
  });
  final String displayableNameCapitalized;
}
