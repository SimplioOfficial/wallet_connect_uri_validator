import 'package:wallet_connect_uri_validator/wallet_connect_uri_validator.dart';

void main() {
  const wcV1UriValid =
      'wc:8a5e5bdc-a0e4-4702-ba63-8f1a5655744f@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=41791102999c339c844880b23950704cc43aa840f3739e365323cda4dfa89e7a';

  const wcV2UriValid =
      'wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=https%3A%2F%2Frelay.walletconnect.com&symKey=7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b';

  print(WalletConnectUri.parse(wcV1UriValid));
  print(WalletConnectUri.parse(wcV2UriValid));
}
