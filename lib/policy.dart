import 'package:virtru_sdk_flutter/common/policy.dart'
    if (dart.library.html) 'package:virtru_sdk_flutter/web/policy.dart';

abstract class Policy {
  factory Policy() => PolicyImpl();

  void setExpirationInDays(int days);

  void setExpirationInMinutes(int minutes);

  void setExpirationDate(DateTime? dateTime);

  void removeExpiration();

  void setWatermarkEnabled(bool watermarkEnabled);

  void setPersistentProtectionEnabled(bool ppEnabled);

  void setPreventDownloadEnabled(bool pdEnabled);

  void setReshareEnable(bool reshareEnabled);

  void setCopyEnabled(bool copyEnabled);

  void setPrintEnabled(bool printEnabled);
}
