import 'package:test/test.dart';
import 'package:wallet_connect_uri_validator/wallet_connect_uri_validator.dart';

const protocol = 'wc';
const version = '1';
const topic = '4acd9fa1-4350-4ddd-b31c-e22fa7bee8d0';
const bridge = 'https://v.bridge.walletconnect.org';
const key = '02eb8db0de49ccc186fb6bf5492d040148c538f0c27412a5431a90a1bf42a27d';
const wcV1UriValid = 'wc:$topic@$version?bridge=$bridge&key=$key';

void main() {
  group(
    'WalletConnect v1 URI parsing:',
    () {
      test(
        'Parsing an empty string throws an exception',
        () {
          expect(
            () => WalletConnectV1Uri.parse(''),
            throwsException,
          );
        },
      );

      test(
        'Trying to parse a non-WalletConnect URI throws an exception',
        () {
          expect(
            () => WalletConnectV1Uri.parse('https://example.com'),
            throwsException,
          );
        },
      );

      test(
        'Trying to parse a non-WalletConnect URI returns null',
        () {
          expect(
            WalletConnectV1Uri.tryParse('https://example.com'),
            isNull,
          );
        },
      );

      test(
        'Trying to parse a valid WalletConnect v1 URI returns an object',
        () {
          expect(
            WalletConnectV1Uri.tryParse(wcV1UriValid),
            isNotNull,
          );
        },
      );

      test(
        'Trying to parse a valid WalletConnect v1 URI returns a WalletConnectV1Uri object',
        () {
          expect(
            WalletConnectV1Uri.tryParse(wcV1UriValid),
            isA<WalletConnectV1Uri>(),
          );
        },
      );
    },
  );

  group(
    'WalletConnect v1 URI checking values:',
    () {
      final uri = WalletConnectV1Uri.parse(wcV1UriValid);

      test(
        'Returns a valid protocol value from valid URI',
        () {
          expect(uri.protocol, protocol);
        },
      );

      test(
        'Returns a valid topic value from valid URI',
        () {
          expect(uri.topic, topic);
        },
      );

      test(
        'Returns a valid version value from valid URI',
        () {
          expect(uri.version, WalletConnectVersion.v1);
        },
      );

      test(
        'Returns a valid bridge value from valid URI',
        () {
          expect(uri.bridge, bridge);
        },
      );

      test(
        'Returns a valid key value from valid URI',
        () {
          expect(uri.key, key);
        },
      );

      test(
        'Returns a valid uri value from valid URI',
        () {
          expect(uri.uri, isNotNull);
          expect(uri.uri, isNotEmpty);
        },
      );
    },
  );
}
