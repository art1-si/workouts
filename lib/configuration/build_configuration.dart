/// The app build configuration (matches Flutter Flavor)
enum BuildConfiguration { dev, uat, production }

/// Provides details about the configuration of the app
class AppConfiguration {
  /// Returns the current build configuration
  static BuildConfiguration get buildConfiguration {
    const value = String.fromEnvironment('CONFIGURATION', defaultValue: 'dev');
    switch (value) {
      case 'dev':
        return BuildConfiguration.dev;

      case 'uat':
        return BuildConfiguration.uat;

      case 'store':
      default:
        return BuildConfiguration.production;
    }
  }

  /// True if this is the dev configuration
  static bool get isDev => AppConfiguration.buildConfiguration == BuildConfiguration.dev;
}
