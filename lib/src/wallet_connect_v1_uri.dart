part of 'wallet_connect_uri.dart';

/// WalletConnect v1 URI
///
/// WalletConnect v1 URI parses and stores all fields from a valid WalletConnect v1 URI.
/// WalletConnect V1 URI is based on [eip-1328](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1328.md)
class WalletConnectV1Uri extends WalletConnectUri {
  /// Parse [WalletConnectV1Uri] from [String] that contains a valid WalletConnect v1 URI.
  /// It will throw a [FormatException] if the uri is not valid.
  static WalletConnectV1Uri parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);

    if (u == null) {
      throw const FormatException(
        'Invalid WalletConnect v1 URI',
      );
    }

    final topic = u.path.contains('@') ? u.path.split('@').first : u.path;
    final params = u.queryParameters;

    return WalletConnectV1Uri(
      protocol: u.scheme,
      topic: topic,
      version: WalletConnectVersion.parse(u.path),
      bridge: params['bridge'] ?? '',
      key: params['key'] ?? '',
    );
  }

  /// Try to parse does not throw an exception if the string is not a valid.
  /// Instead, it returns a nullable [WalletConnectV1Uri] value.
  static WalletConnectV1Uri? tryParse(String uri) {
    try {
      return WalletConnectV1Uri.parse(uri);
    } catch (_) {
      return null;
    }
  }

  /// Bridge is a bridge url that is used to forward requests
  /// to the WalletConnect server.
  final String bridge;

  /// Key is a public key that is used to encrypt and decrypt messages.
  /// It is always present in a valid WalletConnect v1 URI.
  /// It is a hex encoded [String].
  final String key;

  WalletConnectV1Uri({
    required super.protocol,
    required super.topic,
    required super.version,
    required this.bridge,
    required this.key,
  });

  /// Get [String] representation of [WalletConnectV1Uri].
  /// It does not have to be the same as the original string as it is normalized.
  @override
  String get uri => WalletConnectUriConvertor.toStr(this);

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
}
