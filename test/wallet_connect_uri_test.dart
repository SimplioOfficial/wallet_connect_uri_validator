import 'package:test/test.dart';
import 'package:wallet_connect_uri_validator/wallet_connect_uri_validator.dart';

// TODO - add test for returning original from `uri` getter.

const wcV1UriValid =
    'wc:4acd9fa1-4350-4ddd-b31c-e22fa7bee8d0@1?bridge=https%3A%2F%2Fv.bridge.walletconnect.org&key=02eb8db0de49ccc186fb6bf5492d040148c538f0c27412a5431a90a1bf42a27d';

const wcV2UriValid =
    'wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=waku&symKey=7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b';

void main() {
  group('WalletConnect URI parsing:', () {
    test(
      'parsing an empty string throws an exception',
      () {
        expect(() => WalletConnectUri.parse(''), throwsException);
      },
    );

    test(
      'parsing URI with other than wc:// scheme throws an exception',
      () {
        expect(() => WalletConnectUri.parse('https://'), throwsException);
      },
    );

    test(
      'trying to parse a non-WalletConnect URI throws an exception',
      () {
        expect(
          () => WalletConnectUri.parse('https://example.com'),
          throwsException,
        );
      },
    );

    test(
      'parsing ',
      () {
        expect(
          () => WalletConnectUri.parse('wc://'),
          throwsFormatException,
        );
      },
    );

    test(
      'trying to parse a non-WalletConnect URI returns null',
      () {
        expect(WalletConnectUri.tryParse('https://example.com'), isNull);
      },
    );

    test(
      'trying to parse a valid WalletConnect v1 URI returns an object',
      () {
        expect(WalletConnectUri.tryParse(wcV1UriValid), isNotNull);
      },
    );

    test(
      'trying to parse a valid WalletConnect v1 URI returns a WalletConnectV1Uri object',
      () {
        expect(
          WalletConnectUri.tryParse(wcV1UriValid),
          isA<WalletConnectV1Uri>(),
        );
      },
    );

    test(
      'trying to parse a valid WalletConnect v2 URI returns an object',
      () {
        expect(
          WalletConnectUri.tryParse(wcV2UriValid),
          isA<WalletConnectV2Uri>(),
        );
      },
    );
  });
}
