import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

class Policy {
  final VPolicyPtr ptr;

  factory Policy() => Policy._(bindings.VPolicyCreate());

  Policy._(this.ptr);

  void setExpirationInDays(int days) {
    bindings.VExpireInDays(ptr, days);
  }

  void setExpirationInMinutes(int minutes) {
    bindings.VExpireInMins(ptr, minutes);
  }

  void setExpirationDate(DateTime? dateTime) {
    if (dateTime == null) {
      bindings.VRemoveExpiration(ptr);
      return;
    }
    final dateString = dateTime.toUtc().toIso8601String();
    bindings.VAddExpiration(ptr, dateString.toNativeUtf8().cast());
  }

  void removeExpiration() {
    bindings.VRemoveExpiration(ptr);
  }

  void setWatermarkEnabled(bool watermarkEnabled) {
    if (watermarkEnabled) {
      bindings.VEnableWatermarking(ptr);
    } else {
      bindings.VDisableWatermarking(ptr);
    }
  }

  void setPersistentProtectionEnabled(bool ppEnabled) {
    if (ppEnabled) {
      bindings.VEnablePersistentProtection(ptr);
    } else {
      bindings.VDisablePersistentProtection(ptr);
    }
  }

  void setPreventDownloadEnabled(bool pdEnabled) {
    if (pdEnabled) {
      bindings.VEnablePreventDownload(ptr);
    } else {
      bindings.VDisablePreventDownload(ptr);
    }
  }

  void setReshareEnable(bool reshareEnabled) {
    if (reshareEnabled) {
      bindings.VEnableReshare(ptr);
    } else {
      bindings.VDisableReshare(ptr);
    }
  }

  void setCopyEnabled(bool copyEnabled) {
    if (copyEnabled) {
      bindings.VEnableCopy(ptr);
    } else {
      bindings.VDisableCopy(ptr);
    }
  }

  void setPrintEnabled(bool printEnabled) {
    if (printEnabled) {
      bindings.VEnablePrint(ptr);
    } else {
      bindings.VDisablePrint(ptr);
    }
  }
}
