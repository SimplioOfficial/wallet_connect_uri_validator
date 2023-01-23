import 'package:test/test.dart';
import 'package:wallet_connect_uri_validator/wallet_connect_uri_validator.dart';

const wcV2UriValid =
    'wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=waku&symKey=7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b';

void main() {
  group(
    'WalletConnect URI validating valid uri:',
    () {
      final url = WalletConnectV2Uri.parse(wcV2UriValid);
      final validator = WalletConnectV2UriValidator(url);

      test(
        'validating a valid WalletConnect v2 URI returns isValid = true',
        () {
          expect(validator.isValid, isTrue);
        },
      );

      test(
        'validating a valid WalletConnect v2 URI does not have errors',
        () {
          expect(validator.errors, isEmpty);
        },
      );
    },
  );

  group(
    'WalletConnect URI validating uri segments:',
    () {
      test(
        'Validating a valid protocol',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateProtocol('wc'),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid protocol',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateProtocol('w'),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a valid version',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateVersion(
              WalletConnectVersion.v2,
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid version',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateVersion(
              WalletConnectVersion.unknown,
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a valid topic',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateTopic(
              'c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid topic',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateTopic(
              '',
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a relay protocol',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateRelayProtocol(
              'waku',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid relay protocol',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateRelayProtocol(
              '',
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a valid SymKey',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateSymKey(
              '7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating valid relay data',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateRelayData(
              'af24c0834a37b7971dce23726fcbc23b7e17a39632bebf8e53ddaf33b8b725b9375b72519da9d0f964daf625248f91669b6758d947d8b0f8d5c2dfb186b221ce8b4028784df37431494b2d34bae2ddc5',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid relay data',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateRelayData(
              'invalid-relay-data',
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a missing relay data',
        () {
          expect(
            () => WalletConnectV2UriValidator.validateRelayData(),
            returnsNormally,
          );
        },
      );
    },
  );
}
