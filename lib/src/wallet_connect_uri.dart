import 'package:wallet_connect_uri_validator/src/helpers/wallet_connect_uri_convertor.dart';

part 'wallet_connect_v1_uri.dart';
part 'wallet_connect_v2_uri.dart';

/// WalletConnect URI version
///
/// [WalletConnectVersion.unknown] - Unknown or not supported version
/// [WalletConnectVersion.v1] - WalletConnect v1
/// [WalletConnectVersion.v2] - WalletConnect v2
///
enum WalletConnectVersion {
  unknown(0),
  v1(1),
  v2(2);

  /// Parse [WalletConnectVersion] from [String] that contains version number
  static WalletConnectVersion parse(String value) {
    final s = int.tryParse(value) ?? 0;
    if (s > 0) return from(s);
    return unknown;
  }

  /// Get [WalletConnectVersion] from [int] that contains version number
  static WalletConnectVersion from(int value) {
    return WalletConnectVersion.values.firstWhere(
      (element) => element.version == value,
      orElse: () => unknown,
    );
  }

  final int version;

  const WalletConnectVersion(this.version);
}

/// WalletConnect URI
///
/// WalletConnect URI is a generalization of WalletConnect v1 and v2 URI.
/// It can return a correct uri version type from factory [WalletConnectUri.parse].
/// It contains common fields for both versions.
/// WalletConnect URI is based on [eip-1328](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1328.md)
/// specification.
abstract class WalletConnectUri {
  /// WalletConnect protocol is a uri scheme that matches `wc`. Other schemes
  /// are not valid WalletConnect URIs and therefore will throw a [FormatException].
  final String protocol;

  /// Topic is a unique identifier for the session.
  /// It is always present in a valid WalletConnect URI.
  /// It has a different format for v1 and v2.
  ///
  /// ### WalletConnect v1 URI:
  /// - It holds a valid UUID v4 format.
  ///
  /// ### WalletConnect v2 URI:
  /// - It is a hex encoded [String] generated from a random 32 byte array.
  final String topic;

  /// Version is a version of WalletConnect protocol that is located as a host
  /// in a valid WalletConnect URI.
  final WalletConnectVersion version;

  const WalletConnectUri({
    required this.protocol,
    required this.topic,
    required this.version,
  });

  /// Parse [WalletConnectUri] from [String] that contains WalletConnect URI
  /// It will return a supported uri version type from factory [WalletConnectUri.parse].
  /// If parsing fails, it will throw a [FormatException].
  factory WalletConnectUri.parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);
    if (u == null) throw const FormatException('Invalid WalletConnect URI');

    final v = WalletConnectVersion.parse(u.host);
    if (v == WalletConnectVersion.v1) return WalletConnectV1Uri.parse(uri);
    if (v == WalletConnectVersion.v2) return WalletConnectV2Uri.parse(uri);

    throw const FormatException('Invalid WalletConnect URI');
  }

  /// Try to parse does not throw an exception if the string is not a valid.
  /// Instead, it returns a nullable [WalletConnectUri] value.
  static WalletConnectUri? tryParse(String uri) {
    try {
      return WalletConnectUri.parse(uri);
    } catch (_) {
      return null;
    }
  }

  /// Get [String] representation of [WalletConnectUri].
  /// It does not have to be the same as the original string as it is normalized.
  String get uri;
}
