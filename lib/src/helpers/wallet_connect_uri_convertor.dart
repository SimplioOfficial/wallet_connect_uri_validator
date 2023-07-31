import 'package:wallet_connect_uri_validator/src/wallet_connect_uri.dart';

class WalletConnectUriConvertor {
  static Uri? toUri(String uri) {
    if (uri.isEmpty) return null;

    final u = Uri.tryParse(uri);
    if (u == null) return null;

    if ([
      u.path.isNotEmpty,
      u.isScheme('wc'),
    ].contains(false)) return null;

    return u;
  }

  static String toStr(WalletConnectUri uri) {
    if (uri is WalletConnectV1Uri) {
      return Uri(
        scheme: uri.protocol,
        path: [
          uri.topic,
          uri.version.version.toString(),
        ].join('@'),
        queryParameters: {
          'bridge': uri.bridge,
          'key': uri.key,
        },
      ).toString();
    }

    if (uri is WalletConnectV2Uri) {
      return Uri(
        scheme: uri.protocol,
        path: [
          uri.topic,
          uri.version.version.toString(),
        ].join('@'),
        queryParameters: {
          'relay-protocol': uri.relayProtocol,
          'symKey': uri.symKey,
          if (uri.relayData != null) 'relayData': uri.relayData,
        },
      ).toString();
    }

    return uri.toString();
  }
}
