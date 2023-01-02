part of 'wallet_connect_uri.dart';

class WalletConnectUriV1 extends WalletConnectUri {
  static WalletConnectUriV1 parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);

    if (u == null) {
      throw const FormatException(
        'Invalid WalletConnect URI',
      );
    }

    final params = u.queryParameters;

    return WalletConnectUriV1(
      protocol: u.scheme,
      topic: u.userInfo,
      version: WalletConnectVersion.parse(u.host),
      bridge: params['bridge'] ?? '',
      key: params['key'] ?? '',
    );
  }

  final String key;
  final String bridge;

  WalletConnectUriV1({
    required super.protocol,
    required super.topic,
    required super.version,
    required this.bridge,
    required this.key,
  });

  @override
  String toString() {
    return '''
        WalletConnectUriV1{
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
