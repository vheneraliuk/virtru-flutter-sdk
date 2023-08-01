import 'package:virtru_sdk/common/policy.dart'
    if (dart.library.html) 'package:virtru_sdk/web/policy.dart';

abstract class Policy {
  /// Create a new policy object.
  factory Policy() => PolicyImpl();

  /// Set the [owner] of the TDF
  /// NOTE: By default, the owner is the address that was used when the client instance was created.
  /// This method will change the owner to the specified email address for the instance.
  setOwner(String owner);

  /// Return the owner of the TDF.
  /// NOTE: If the owner is not set, an empty string is return.
  String getOwner();

  /// Set the expiration in days.
  setExpirationInDays(int days);

  /// Set the expiration in minutes.
  setExpirationInMinutes(int minutes);

  /// Access to the TDF data will be revoked for all users at the specified date.
  /// The owner will retain access after the expiration time is reached.
  setExpirationDate(DateTime? dateTime);

  /// Return the expiration date of the TDF.
  /// NOTE: If the expiration is not set, [null] is return.
  DateTime? getExpirationDate();

  /// Remove the expiration.
  removeExpiration();

  /// Turns on/off watermarking policy control flag.
  setWatermarkEnabled(bool watermarkEnabled);

  /// Return the status of 'Watermarking' control flag.
  bool isWatermarkEnabled();

  /// Turns on/off persistent protection policy control flag.
  setPersistentProtectionEnabled(bool ppEnabled);

  /// Return the status of 'PersistentProtection' control flag.
  bool isPersistentProtectionEnabled();

  /// Turns on/off prevent download policy control flag.
  setPreventDownloadEnabled(bool pdEnabled);

  /// Return the status of 'PreventDownload' control flag.
  bool isPreventDownloadEnabled();

  /// Turns on/off reshare policy control flag.
  setReshareEnabled(bool reshareEnabled);

  /// Return the status of 'Reshare' control flag.
  isReshareEnabled();

  /// Turns on/off copy policy control flag.
  setCopyEnabled(bool copyEnabled);

  /// Return the status of 'Copy' control flag.
  bool isCopyEnabled();

  /// Turns on/off print policy control flag.
  setPrintEnabled(bool printEnabled);

  /// Return the status of 'Print' control flag.
  bool isPrintEnabled();

  /// Add access to the TDF file/data for the users in the given [usersEmail] list.
  shareWithUsers(List<String> usersEmail);

  /// Return all the user who have access to the TDF.
  List<String> getSharedUsers();

  /// Remove access to the TDF file/data for the users in the given [usersEmail] list.
  removeUsers(List<String> usersEmail);

  /// Dispose the Policy instance.
  dispose();
}
