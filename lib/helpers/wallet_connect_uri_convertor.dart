import 'package:wallet_connect_uri_validator/main.dart';

class WalletConnectUriConvertor {
  static Uri? toUri(String uri) {
    final u = uri.startsWith('wc:') ? uri.replaceFirst('wc:', 'wc://') : uri;
    return Uri.tryParse(u);
  }

  static String toStr(WalletConnectUri uri) {
    if (uri is WalletConnectUriV1) {
      return Uri(
        scheme: uri.protocol,
        userInfo: uri.topic,
        host: uri.version.version.toString(),
        queryParameters: {
          'bridge': uri.bridge,
          'key': uri.key,
        },
      ).toString();
    }

    if (uri is WalletConnectUriV2) {
      return Uri(
        scheme: uri.protocol,
        userInfo: uri.topic,
        host: uri.version.version.toString(),
        queryParameters: {
          'relayProtocol': uri.relayProtocol,
          'symKey': uri.symKey,
          'relayData': uri.relayData,
        },
      ).toString();
    }

    return uri.toString();
  }
}
