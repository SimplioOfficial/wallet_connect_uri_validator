import 'package:wallet_connect_uri_validator/validators/wallet_connect_uri_validator.dart';
import 'package:wallet_connect_uri_validator/wallet_connect_uri.dart';

mixin WalletConnectUriValidatorMixin {
  bool isWalletConnectUriValid(String uri) {
    try {
      final wcUri = WalletConnectUri.parse(uri);
      return WalletConnectUriValidator.fromUri(wcUri).isValid;
    } catch (_) {
      return false;
    }
  }

  WalletConnectUriValidator validatorFromUri(String uri) {
    final wcUri = WalletConnectUri.parse(uri);
    return WalletConnectUriValidator.fromUri(wcUri);
  }
}
