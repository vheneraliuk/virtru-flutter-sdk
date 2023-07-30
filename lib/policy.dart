import 'package:virtru_sdk_flutter/common/policy.dart'
    if (dart.library.html) 'package:virtru_sdk_flutter/web/policy.dart';

abstract class Policy {
  /// Create a new policy object.
  factory Policy() => PolicyImpl();

  /// Set the expiration in days.
  setExpirationInDays(int days);

  /// Set the expiration in minutes.
  setExpirationInMinutes(int minutes);

  /// Access to the TDF data will be revoked for all users at the specified date.
  /// The owner will retain access after the expiration time is reached.
  setExpirationDate(DateTime? dateTime);

  /// Remove the expiration.
  removeExpiration();

  /// Turns on/off watermarking policy control flag.
  setWatermarkEnabled(bool watermarkEnabled);

  /// Turns on/off persistent protection policy control flag.
  setPersistentProtectionEnabled(bool ppEnabled);

  /// Turns on/off prevent download policy control flag.
  setPreventDownloadEnabled(bool pdEnabled);

  /// Turns on/off reshare policy control flag.
  setReshareEnable(bool reshareEnabled);

  /// Turns on/off copy policy control flag.
  setCopyEnabled(bool copyEnabled);

  /// Turns on/off print policy control flag.
  setPrintEnabled(bool printEnabled);

  /// Add access to the TDF file/data for the users in the given [usersEmail] list.
  shareWithUsers(List<String> usersEmail);

  /// Remove access to the TDF file/data for the users in the given [usersEmail] list.
  removeUsers(List<String> usersEmail);

  /// Dispose the Policy instance.
  dispose();
}
