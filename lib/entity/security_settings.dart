/// Security settings for the secure share.
class SecuritySettings {
  /// Create a new [SecuritySettings] instance.
  /// The [isPersistentProtected] is the flag to enable persistent protection.
  /// The [isWatermarkEnabled] is the flag to enable watermarking.
  /// The [expirationDate] is the expiration date of the secure share.
  SecuritySettings({
    this.isPersistentProtected = false,
    this.isWatermarkEnabled = false,
    this.expirationDate,
  });

  final bool isPersistentProtected;
  final bool isWatermarkEnabled;
  final DateTime? expirationDate;
}
