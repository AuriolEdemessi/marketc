enum Flavor { dev, beta, production }

///Helper widget to help with the flavoring with our app
class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String baseUrl;
  final String fedapayUrl;

  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
    required String fedapayUrl,
  }) {
    return FlavorConfig._internal(flavor, flavor.name, baseUrl, fedapayUrl);
  }

  FlavorConfig._internal(this.flavor, this.name, this.baseUrl, this.fedapayUrl);

  bool get isProduction => flavor == Flavor.production;

  bool get isDevelopment => flavor == Flavor.dev;

  bool get isTesting => flavor == Flavor.beta;
}

extension FlavorName on Flavor {
  String get name {
    switch (this) {
      case Flavor.dev:
        return 'Dev';
      case Flavor.beta:
        return 'Beta';
      case Flavor.production:
        return '';
    }
  }
}
