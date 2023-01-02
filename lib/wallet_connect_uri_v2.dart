part of 'wallet_connect_uri.dart';

class WalletConnectUriV2 extends WalletConnectUri {
  final String symKey;

  /// Default protocol is 'waku'.
  final String relayProtocol;

  /// (optional) HEX encoded data to be sent to the relay server.
  final String? relayData;

  static WalletConnectUriV2 parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);

    if (u == null) {
      throw const FormatException(
        'Invalid WalletConnect URI',
      );
    }

    final params = u.queryParameters;

    return WalletConnectUriV2(
      protocol: u.scheme,
      topic: u.userInfo,
      version: WalletConnectVersion.parse(u.host),
      relayProtocol: params['relayProtocol'] ?? '',
      symKey: params['symKey'] ?? '',
      relayData: params['relayData'],
    );
  }

  const WalletConnectUriV2({
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
        WalletConnectUriV2{
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
