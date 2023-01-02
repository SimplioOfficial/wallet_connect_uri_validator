import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_uri_validator/validators/wallet_connect_uri_validator.dart';
import 'package:wallet_connect_uri_validator/wallet_connect_uri.dart';

const v1a =
    'wc:8a5e5bdc-a0e4-4702-ba63-8f1a5655744f@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=41791102999c339c844880b23950704cc43aa840f3739e365323cda4dfa89e7a';
const v1b =
    'wc:cbf40017-dadd-4367-97e2-984ea9b29839@1?bridge=https%3A%2F%2Fr.bridge.walletconnect.org&key=c12c1ed7843f2494728483cf31ab3d8f69f03b42c4eee39d0f74b65f3be163c7';

const v2 =
    'wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=waku&symKey=7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b';

// const v2 =
//     'wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=waku&symKey=1C8655F398D3CEBD3BAE5F866E5676AC0094CB4C0AE9B2F60A7D6DFDC28E1C9B9C514AC9A000F8FCD4287E27913A9C39B76CF1530FAEDFEC117E6C0D9D82C272';

void main() {
  test('Parsing', () {
    final v1Uri = WalletConnectV1Uri.parse(v1a);
    final v1Validator = WalletConnectV1UriValidator(v1Uri);

    // final v2Uri = WalletConnectUriV2.parse(v1b);
    // final v2Validator = WalletConnectUriV2Validator(v2Uri);

    final uri = WalletConnectUri.parse(v2);
    final validator = WalletConnectUriValidator.fromUri(uri);

    print(uri);
    // print(v2Validator.isValid);
    print(validator.isValid);
    // print(v2Validator.isValid == validator.isValid);
    print(validator.errors);
    // print(v2Validator.errors);
    print(uri.uri);
  });
}
