import 'package:test/test.dart';
import 'package:wallet_connect_uri_validator/wallet_connect_uri_validator.dart';

const protocol = 'wc';
const version = '2';
const topic =
    'c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168';
const relayProtocol = 'waku';
const symKey =
    '7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b';
const wcV2UriValid =
    '$protocol:$topic@$version?relay-protocol=$relayProtocol&symKey=$symKey';

void main() {
  group(
    'WalletConnect v2 URI parsing:',
    () {
      test(
        'Parsing an empty string throws an exception',
        () {
          expect(
            () => WalletConnectV2Uri.parse(''),
            throwsException,
          );
        },
      );

      test(
        'Trying to parse a non-WalletConnect URI throws an exception',
        () {
          expect(
            () => WalletConnectV2Uri.parse('https://example.com'),
            throwsException,
          );
        },
      );

      test(
        'Trying to parse a non-WalletConnect URI returns null',
        () {
          expect(
            WalletConnectV2Uri.tryParse('https://example.com'),
            isNull,
          );
        },
      );

      test(
        'Trying to parse a valid WalletConnect v1 URI returns an object',
        () {
          expect(
            WalletConnectV2Uri.tryParse(wcV2UriValid),
            isNotNull,
          );
        },
      );

      test(
        'Trying to parse a valid WalletConnect v1 URI returns a WalletConnectV2Uri object',
        () {
          expect(
            WalletConnectV2Uri.tryParse(wcV2UriValid),
            isA<WalletConnectV2Uri>(),
          );
        },
      );
    },
  );
  group(
    'WalletConnect v2 URI values:',
    () {
      final uri = WalletConnectV2Uri.parse(wcV2UriValid);

      test(
        'checking the protocol value',
        () {
          expect(uri.protocol, 'wc');
        },
      );

      test(
        'checking the topic value',
        () {
          expect(uri.topic, topic);
        },
      );

      test(
        'checking the version value',
        () {
          expect(uri.version, WalletConnectVersion.v2);
        },
      );

      test(
        'checking relay protocol value',
        () {
          expect(uri.relayProtocol, relayProtocol);
        },
      );

      test(
        'checking symKey value',
        () {
          expect(uri.symKey, symKey);
        },
      );

      test(
        'checking relayData value',
        () {
          expect(uri.relayData, isNull);
        },
      );

      test(
        'checking the uri value',
        () {
          expect(uri.uri, isNotNull);
          expect(uri.uri, isNotEmpty);
        },
      );
    },
  );
}
