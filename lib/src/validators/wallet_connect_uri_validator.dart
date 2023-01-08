import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_connect_uri_validator/src/errors/wallet_connect_uri_validation_error.dart';
import 'package:wallet_connect_uri_validator/src/wallet_connect_uri.dart';

part 'wallet_connect_v1_uri_validator.dart';
part 'wallet_connect_v2_uri_validator.dart';

/// WalletConnect URI validator.
///
/// A validator for [WalletConnectUri] objects.
/// It contains static methods for validating common URI segments.
abstract class WalletConnectUriValidator {
  /// Validate WalletConnect protocol
  /// that should be always present with a value `wc`.
  /// It throws [WalletConnectUriValidationError] if protocol is invalid.
  static void validateProtocol(String protocol) {
    if (protocol == 'wc') return;
    throw const WalletConnectUriValidationError(
      message: 'Invalid protocol',
    );
  }

  /// Validate WalletConnect version
  /// Version should be always present with a value `1` or `2`.
  /// It can be compared with [compareTo] parameter to a specific version.
  /// It throws [WalletConnectUriValidationError] if version is 'unknown'
  /// or does not match [compareTo] parameter.
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

  /// Validate WalletConnect topic
  /// Valid topic should be always present otherwise it throws ArgumentError.
  /// Validating topic depends on the version of WalletConnect protocol.
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

  /// Validator contains an instance of provided [WalletConnectUri].
  WalletConnectUri get uri;

  /// Validator contains a set of [WalletConnectUriValidationError] errors.
  Set<WalletConnectUriValidationError> get errors;

  /// Validator contains a boolean value indicating
  /// if there are any validation errors after initialization.
  bool get isValid => errors.isEmpty;

  const WalletConnectUriValidator();

  factory WalletConnectUriValidator.fromUri(WalletConnectUri uri) {
    if (uri is WalletConnectV1Uri) return WalletConnectV1UriValidator(uri);
    if (uri is WalletConnectV2Uri) return WalletConnectV2UriValidator(uri);
    throw ArgumentError.value(uri, 'uri', 'Invalid WalletConnectUri');
  }
}
