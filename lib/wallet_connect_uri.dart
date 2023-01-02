import 'package:wallet_connect_uri_validator/helpers/wallet_connect_uri_convertor.dart';

part 'wallet_connect_uri_v1.dart';
part 'wallet_connect_uri_v2.dart';

enum WalletConnectVersion {
  unknown(0),
  v1(1),
  v2(2);

  const WalletConnectVersion(this.version);

  final int version;

  static WalletConnectVersion parse(String value) {
    final s = double.tryParse(value) ?? 0;
    if (s > 0) return from(s);
    return unknown;
  }

  static WalletConnectVersion from(double value) {
    return WalletConnectVersion.values.firstWhere(
      (element) => element.version == value,
      orElse: () => unknown,
    );
  }
}

abstract class WalletConnectUri {
  final String protocol;
  final String topic;
  final WalletConnectVersion version;

  const WalletConnectUri({
    required this.protocol,
    required this.topic,
    required this.version,
  });

  factory WalletConnectUri.parse(String uri) {
    final u = WalletConnectUriConvertor.toUri(uri);
    if (u == null) throw const FormatException('Invalid WalletConnect URI');

    final v = WalletConnectVersion.parse(u.host);
    if (v == WalletConnectVersion.v1) return WalletConnectUriV1.parse(uri);
    if (v == WalletConnectVersion.v2) return WalletConnectUriV2.parse(uri);

    throw const FormatException('Invalid WalletConnect URI');
  }

  static WalletConnectUri? tryParse(String uri) {
    try {
      return WalletConnectUri.parse(uri);
    } catch (e) {
      return null;
    }
  }

  String get uri;
}
