import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_connect_uri_validator/src/errors/wallet_connect_uri_validation_error.dart';
import 'package:wallet_connect_uri_validator/src/wallet_connect_uri.dart';

part 'wallet_connect_v1_uri_validator.dart';
part 'wallet_connect_v2_uri_validator.dart';

abstract class WalletConnectUriValidator {
  static void validateProtocol(String protocol) {
    if (protocol == 'wc') return;
    throw const WalletConnectUriValidationError(
      message: 'Invalid protocol',
    );
  }

  static void validateVersion(
    WalletConnectVersion version, {
    WalletConnectVersion? compareTo,
  }) {
    if (compareTo != null) {
      if (version == compareTo) return;
      throw WalletConnectUriValidationError(
        message: 'Version does not match: $compareTo',
      );
    }

    if (version != WalletConnectVersion.unknown) return;
    throw const WalletConnectUriValidationError(
      message: 'Invalid version',
    );
  }

  static Set<WalletConnectUriValidationError> validate(
    WalletConnectUri uri,
  ) {
    if (uri is WalletConnectV1Uri) {
      return WalletConnectV1UriValidator.validate(uri);
    }
    if (uri is WalletConnectV2Uri) {
      return WalletConnectV2UriValidator.validate(uri);
    }

    throw ArgumentError.value(uri, 'uri', 'Invalid WalletConnectUri');
  }

  WalletConnectUri get uri;
  Set<WalletConnectUriValidationError> get errors;

  const WalletConnectUriValidator();

  factory WalletConnectUriValidator.fromUri(WalletConnectUri uri) {
    if (uri is WalletConnectV1Uri) return WalletConnectV1UriValidator(uri);
    if (uri is WalletConnectV2Uri) return WalletConnectV2UriValidator(uri);
    throw ArgumentError.value(uri, 'uri', 'Invalid WalletConnectUri');
  }

  bool get isValid => errors.isEmpty;
}