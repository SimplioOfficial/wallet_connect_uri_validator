part of 'wallet_connect_uri.dart';

class WalletConnectV1Uri extends WalletConnectUri {
  static WalletConnectV1Uri parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);

    if (u == null) {
      throw const FormatException(
        'Invalid WalletConnect v1 URI',
      );
    }

    final params = u.queryParameters;

    return WalletConnectV1Uri(
      protocol: u.scheme,
      topic: u.userInfo,
      version: WalletConnectVersion.parse(u.host),
      bridge: params['bridge'] ?? '',
      key: params['key'] ?? '',
    );
  }

  final String key;
  final String bridge;

  WalletConnectV1Uri({
    required super.protocol,
    required super.topic,
    required super.version,
    required this.bridge,
    required this.key,
  });

  @override
  String toString() {
    return '''
        WalletConnectV1Uri{
          protocol: $protocol, 
          topic: $topic, 
          version: $version, 
          bridge: $bridge, 
          key: $key
          }
    ''';
  }

  @override
  String get uri => WalletConnectUriConvertor.toStr(this);
}
