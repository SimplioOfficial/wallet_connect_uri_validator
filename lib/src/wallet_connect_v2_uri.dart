part of 'wallet_connect_uri.dart';

class WalletConnectV2Uri extends WalletConnectUri {
  final String symKey;

  /// Default protocol is 'waku'.
  final String relayProtocol;

  /// (optional) HEX encoded data to be sent to the relay server.
  final String? relayData;

  static WalletConnectV2Uri parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);

    if (u == null) {
      throw const FormatException(
        'Invalid WalletConnect v2 URI',
      );
    }

    final params = u.queryParameters;

    return WalletConnectV2Uri(
      protocol: u.scheme,
      topic: u.userInfo,
      version: WalletConnectVersion.parse(u.host),
      relayProtocol: params['relay-protocol'] ?? '',
      symKey: params['symKey'] ?? '',
      relayData: params['relayData'],
    );
  }

  static WalletConnectV2Uri? tryParse(String uri) {
    try {
      return WalletConnectV2Uri.parse(uri);
    } catch (_) {
      return null;
    }
  }

  const WalletConnectV2Uri({
    required super.protocol,
    required super.topic,
    required super.version,
    required this.symKey,
    required this.relayProtocol,
    this.relayData,
  });

  @override
  String toString() {
    return '''
        WalletConnectV2Uri{
          protocol: $protocol, 
          topic: $topic, 
          version: $version, 
          symKey: $symKey, 
          relayProtocol: $relayProtocol, 
          relayData: $relayData
          }
    ''';
  }

  @override
  String get uri => WalletConnectUriConvertor.toStr(this);
}
