import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_uri_validator/src/validators/wallet_connect_uri_validator.dart';
import 'package:wallet_connect_uri_validator/src/wallet_connect_uri.dart';

void main() {
  group(
    'WalletConnect validator URI parsing:',
    () {
      test(
        'Validator returns no errors for a valid URI',
        () {
          const wcV1UriValid =
              'wc:4acd9fa1-4350-4ddd-b31c-e22fa7bee8d0@1?bridge=https%3A%2F%2Fv.bridge.walletconnect.org&key=02eb8db0de49ccc186fb6bf5492d040148c538f0c27412a5431a90a1bf42a27d';
          final uri = WalletConnectUri.parse(wcV1UriValid);
          expect(
            WalletConnectUriValidator.fromUri(uri).errors,
            isEmpty,
          );
        },
      );

      test(
        'Validator returns an error for an invalid URI',
        () {
          const wcV1UriInvalid =
              'wc:4acd9fa1-4350-4ddd-b31c@1?bridge=https%3A%2F%2Fv.bridge.walletconnect.org&key=02eb8db0de49ccc186fb6bf5492d040148c538f0c27412a5431a90a1bf42a27d';
          final uri = WalletConnectUri.parse(wcV1UriInvalid);
          expect(
            WalletConnectUriValidator.fromUri(uri).errors,
            isNotEmpty,
          );
        },
      );

      test(
        'Validator returns no errors for a valid v2 URI',
        () {
          const wcV2UriValid =
              'wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=waku&symKey=7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b';
          final uri = WalletConnectUri.parse(wcV2UriValid);
          expect(
            WalletConnectUriValidator.fromUri(uri).errors,
            isEmpty,
          );
        },
      );

      test(
        'Validator returns a WalletConnectV2UriValidator for a valid v2 URI',
        () {
          const wcV2UriValid =
              'wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=waku&symKey=7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b';
          final uri = WalletConnectUri.parse(wcV2UriValid);
          expect(
            WalletConnectUriValidator.fromUri(uri),
            isA<WalletConnectV2UriValidator>(),
          );
        },
      );

      test(
        'Validator returns an error for an invalid v2 URI',
        () {
          const wcV2UriInvalid =
              'wc:invalid-topic@2?relay-protocol=waku&symKey=invalid-sym-key';
          final uri = WalletConnectUri.parse(wcV2UriInvalid);
          expect(
            WalletConnectUriValidator.fromUri(uri).errors,
            isNotEmpty,
          );
        },
      );
    },
  );
}
