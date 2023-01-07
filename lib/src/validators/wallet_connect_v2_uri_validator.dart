part of 'wallet_connect_uri_validator.dart';

/// For WalletConnect v2.0 protocol (version=2) the parameters are:
///
/// symKey - symmetric key used for encrypting messages over relay
/// relay-protocol - transport protocol for relaying messages
/// relay-data - (optional) transport data for relaying messages

class WalletConnectV2UriValidator extends WalletConnectUriValidator {
  static Set<WalletConnectUriValidationError> validate(
    WalletConnectV2Uri uri,
  ) {
    final Set<WalletConnectUriValidationError> errors = {};

    try {
      validateProtocol(uri.protocol);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateTopic(uri.topic);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateVersion(uri.version);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateSymKey(uri.symKey);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateRelayProtocol(uri.relayProtocol);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateRelayData(uri.relayData);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    return errors;
  }

  static void validateProtocol(String protocol) {
    return WalletConnectUriValidator.validateProtocol(protocol);
  }

  /// Topic v2 is uft8 encoded random generated string of default size 32 bytes.
  static void validateTopic(String topic) {
    final bytes = Uint8List.fromList(utf8.encoder.convert(topic));

    if (bytes.isEmpty) {
      throw const WalletConnectUriValidationError(
        message: 'Topic is empty',
      );
    }

    return;
  }

  static void validateVersion(WalletConnectVersion version) {
    return WalletConnectUriValidator.validateVersion(
      version,
      compareTo: WalletConnectVersion.v2,
    );
  }

  static void validateRelayProtocol(String protocol) {
    if (protocol.isEmpty) {
      throw const WalletConnectUriValidationError(
        message: 'Invalid relay protocol',
      );
    }
    return;
  }

  static void validateRelayData([String? data]) {
    if (data == null || data.isEmpty) return;

    try {
      if (hex.decode(data).isEmpty) throw Exception();
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Relay Data are not valid hex string',
      );
    }
  }

  /// Symmetric key is a 256-bit sized hex string.
  /// [reference](https://github.com/WalletConnect/WalletConnectSwiftV2/blob/main/Sources/WalletConnectKMS/Crypto/SymmetricKey.swift)
  static void validateSymKey(String key) {
    try {
      if (hex.decode(key).isEmpty) throw Exception();
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Symmetric key is not valid hex string',
      );
    }

    final bytes = Uint8List.fromList(utf8.encoder.convert(key));

    if (bytes.isEmpty) {
      throw const WalletConnectUriValidationError(
        message: 'Symmetric key is empty',
      );
    }

    switch (bytes.length) {
      case 64:
        break;
      default:
        throw const WalletConnectUriValidationError(
          message: 'Symmetric key does not have a valid length',
        );
    }

    return;
  }

  const WalletConnectV2UriValidator._({
    required this.uri,
    required this.errors,
  });

  WalletConnectV2UriValidator(WalletConnectV2Uri uri)
      : this._(uri: uri, errors: validate(uri));

  @override
  final WalletConnectV2Uri uri;

  @override
  final Set<WalletConnectUriValidationError> errors;

  @override
  bool get isValid => errors.isEmpty;
}
