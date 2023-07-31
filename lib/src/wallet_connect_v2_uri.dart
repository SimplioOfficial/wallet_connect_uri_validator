part of 'wallet_connect_uri.dart';

/// WalletConnect v2 URI
///
/// WalletConnect v2 URI parses and stores all fields from a valid WalletConnect v2 URI.
/// WalletConnect V2 URI is based on [eip-1328](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1328.md)
class WalletConnectV2Uri extends WalletConnectUri {
  /// Parse [WalletConnectV2Uri] from [String] that contains a valid WalletConnect v2 URI.
  /// It will throw a [FormatException] if the uri is not valid.
  static WalletConnectV2Uri parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);

    if (u == null) {
      throw const FormatException(
        'Invalid WalletConnect v2 URI',
      );
    }

    final topic = u.path.contains('@') ? u.path.split('@').first : u.path;
    final params = u.queryParameters;

    return WalletConnectV2Uri(
      protocol: u.scheme,
      topic: topic,
      version: WalletConnectVersion.parse(u.path),
      relayProtocol: params['relay-protocol'] ?? '',
      symKey: params['symKey'] ?? '',
      relayData: params['relayData'],
    );
  }

  /// Try to parse does not throw an exception if the string is not a valid.
  /// Instead, it returns a nullable [WalletConnectV2Uri] value.
  static WalletConnectV2Uri? tryParse(String uri) {
    try {
      return WalletConnectV2Uri.parse(uri);
    } catch (_) {
      return null;
    }
  }

  /// Symmetric key is a key that is used to encrypt and decrypt messages.
  /// It is a 256 bit hex encoded [String] [viz switft implementation](https://github.com/WalletConnect/WalletConnectSwiftV2/blob/main/Sources/WalletConnectKMS/Crypto/SymmetricKey.swift).
  final String symKey;

  /// Relay protocol is a protocol that is used to forward requests to the relay server.
  /// Default relay protocol is `waku`.
  final String relayProtocol;

  /// Relay data are optional value provided byt the dapp.
  /// It is used to provide additional information to the relay server.
  /// It is hex encoded [String].
  final String? relayData;

  const WalletConnectV2Uri({
    required super.protocol,
    required super.topic,
    required super.version,
    required this.symKey,
    required this.relayProtocol,
    this.relayData,
  });

  /// Get [String] representation of [WalletConnectV2Uri].
  /// It does not have to be the same as the original string as it is normalized.
  @override
  String get uri => WalletConnectUriConvertor.toStr(this);

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
}
