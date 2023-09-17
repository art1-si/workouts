/// The app build configuration (matches Flutter Flavor)
enum BuildConfiguration { dev, internal, uat, acceptance, store }

/// Provides details about the configuration of the app
class AppConfiguration {
  /// Returns the current build configuration
  static BuildConfiguration get buildConfiguration {
    const value = String.fromEnvironment('CONFIGURATION', defaultValue: 'dev');
    switch (value) {
      case 'dev':
        return BuildConfiguration.dev;
      case 'internal':
        return BuildConfiguration.internal;
      case 'uat':
        return BuildConfiguration.uat;
      case 'acceptance':
        return BuildConfiguration.acceptance;
      case 'store':
      default:
        return BuildConfiguration.store;
    }
  }

  /// True if this is the dev configuration
  static bool get isDev => AppConfiguration.buildConfiguration == BuildConfiguration.dev;
}
