import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/policy.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter_bindings.dart';

class PolicyImpl implements Policy {
  final VPolicyPtr ptr;

  factory PolicyImpl() => PolicyImpl._(bindings.VPolicyCreate());

  PolicyImpl._(this.ptr);

  @override
  void setExpirationInDays(int days) {
    bindings.VExpireInDays(ptr, days);
  }

  @override
  void setExpirationInMinutes(int minutes) {
    bindings.VExpireInMins(ptr, minutes);
  }

  @override
  void setExpirationDate(DateTime? dateTime) {
    if (dateTime == null) {
      bindings.VRemoveExpiration(ptr);
      return;
    }
    final dateString = dateTime.toUtc().toIso8601String();
    bindings.VAddExpiration(ptr, dateString.toNativeUtf8().cast());
  }

  @override
  void removeExpiration() {
    bindings.VRemoveExpiration(ptr);
  }

  @override
  void setWatermarkEnabled(bool watermarkEnabled) {
    if (watermarkEnabled) {
      bindings.VEnableWatermarking(ptr);
    } else {
      bindings.VDisableWatermarking(ptr);
    }
  }

  @override
  void setPersistentProtectionEnabled(bool ppEnabled) {
    if (ppEnabled) {
      bindings.VEnablePersistentProtection(ptr);
    } else {
      bindings.VDisablePersistentProtection(ptr);
    }
  }

  @override
  void setPreventDownloadEnabled(bool pdEnabled) {
    if (pdEnabled) {
      bindings.VEnablePreventDownload(ptr);
    } else {
      bindings.VDisablePreventDownload(ptr);
    }
  }

  @override
  void setReshareEnable(bool reshareEnabled) {
    if (reshareEnabled) {
      bindings.VEnableReshare(ptr);
    } else {
      bindings.VDisableReshare(ptr);
    }
  }

  @override
  void setCopyEnabled(bool copyEnabled) {
    if (copyEnabled) {
      bindings.VEnableCopy(ptr);
    } else {
      bindings.VDisableCopy(ptr);
    }
  }

  @override
  void setPrintEnabled(bool printEnabled) {
    if (printEnabled) {
      bindings.VEnablePrint(ptr);
    } else {
      bindings.VDisablePrint(ptr);
    }
  }
}
