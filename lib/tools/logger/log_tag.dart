enum LogTag {
  widget(displayableNameCapitalized: 'WIDGET'),
  caster(displayableNameCapitalized: 'CASTER'),
  router(displayableNameCapitalized: 'ROUTER'),
  ;

  const LogTag({
    required this.displayableNameCapitalized,
  });
  final String displayableNameCapitalized;
}
