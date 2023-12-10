enum GraphProperties {
  perWeight,
  oneRepMax,
  simpleVolumePerSet;

  String propertiesToString() {
    switch (this) {
      case GraphProperties.perWeight:
        return 'Max weight';

      case GraphProperties.oneRepMax:
        return 'Epley one rep max';

      case GraphProperties.simpleVolumePerSet:
        return 'Volume per set';
    }
  }
}
