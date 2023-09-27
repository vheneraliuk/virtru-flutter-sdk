import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:virtru_sdk/client.dart';

class SecureShareLink extends Equatable {
  final String policyUuid;
  final String metadataKey;
  final Environment env;

  const SecureShareLink._(this.policyUuid, this.metadataKey, this.env);

  /// Parses the [secureShareUrl] and returns a [SecureShareLink] instance.
  static SecureShareLink? parse(String secureShareUrl) {
    // https://secure.virtru.com/secure-share/shared/vladyslav.heneraliuk@gmail.com/dee2714f-03ff-4d77-afb2-95165de3083b#ek=W%2FJbOnyRE5CjANsRoGiRnWc5mTGpqQw50rcSqY4ZT8w%3D

    final tempUri = Uri.tryParse(secureShareUrl);
    if (tempUri == null) return null;

    final secureShareUri = _replaceFragmentByQueryParams(tempUri);

    final policyUuid = secureShareUri.pathSegments.last;

    if (!_policyIdRegExp.hasMatch(policyUuid)) return null;

    final metadataKey = secureShareUri.queryParameters["ek"];

    if (metadataKey == null) return null;

    final env = _getEnv(secureShareUri);

    if (env == null) return null;

    return SecureShareLink._(policyUuid, metadataKey, env);
  }

  /// Creates a secure share link URL.
  static String create(
    Environment env,
    String owner,
    String policyUuid,
    List<int> metadataKey,
  ) {
    return '${env.secureShareUrl}/shared/$owner/$policyUuid#ek=${Uri.encodeComponent(base64Encode(metadataKey))}';
  }

  static Environment? _getEnv(Uri secureShareUri) {
    final host = secureShareUri.host;

    if (host.isEmpty) return null;

    if (Environment.prod.secureShareUrl.contains(host)) {
      return Environment.prod;
    }
    if (Environment.staging.secureShareUrl.contains(host)) {
      return Environment.staging;
    }
    if (Environment.dev.secureShareUrl.contains(host)) {
      return Environment.dev;
    }
  }

  static Uri _replaceFragmentByQueryParams(Uri uri) {
    Uri newUri = uri;

    if (uri.hasFragment) {
      var fragment = uri.fragment;
      var uriWithoutFragment = uri.removeFragment();
      var hasParams = uriWithoutFragment.queryParameters.isNotEmpty;
      newUri =
          Uri.parse('$uriWithoutFragment${hasParams ? '&' : '?'}$fragment');
    }

    return newUri;
  }

  static final _policyIdRegExp = RegExp(
    r'[a-hA-H0-9]{8}-[a-hA-H0-9]{4}-[a-hA-H0-9]{4}-[a-hA-H0-9]{4}-[a-hA-H0-9]{12}',
  );

  @override
  List<Object?> get props => [policyUuid, metadataKey, env];
}
