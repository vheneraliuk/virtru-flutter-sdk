import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/policy.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter_bindings.dart';

class PolicyImpl implements Policy {
  final VPolicyPtr ptr;

  factory PolicyImpl() => PolicyImpl.fromPtr(bindings.VPolicyCreate());

  PolicyImpl.fromPtr(this.ptr);

  @override
  setExpirationInDays(int days) {
    bindings.VExpireInDays(ptr, days);
  }

  @override
  setExpirationInMinutes(int minutes) {
    bindings.VExpireInMins(ptr, minutes);
  }

  @override
  setExpirationDate(DateTime? dateTime) {
    if (dateTime == null) {
      bindings.VRemoveExpiration(ptr);
      return;
    }
    final dateString = dateTime.toUtc().toIso8601String();
    bindings.VAddExpiration(ptr, dateString.toNativeUtf8().cast());
  }

  @override
  removeExpiration() {
    bindings.VRemoveExpiration(ptr);
  }

  @override
  setWatermarkEnabled(bool watermarkEnabled) {
    if (watermarkEnabled) {
      bindings.VEnableWatermarking(ptr);
    } else {
      bindings.VDisableWatermarking(ptr);
    }
  }

  @override
  setPersistentProtectionEnabled(bool ppEnabled) {
    if (ppEnabled) {
      bindings.VEnablePersistentProtection(ptr);
    } else {
      bindings.VDisablePersistentProtection(ptr);
    }
  }

  @override
  setPreventDownloadEnabled(bool pdEnabled) {
    if (pdEnabled) {
      bindings.VEnablePreventDownload(ptr);
    } else {
      bindings.VDisablePreventDownload(ptr);
    }
  }

  @override
  setReshareEnable(bool reshareEnabled) {
    if (reshareEnabled) {
      bindings.VEnableReshare(ptr);
    } else {
      bindings.VDisableReshare(ptr);
    }
  }

  @override
  setCopyEnabled(bool copyEnabled) {
    if (copyEnabled) {
      bindings.VEnableCopy(ptr);
    } else {
      bindings.VDisableCopy(ptr);
    }
  }

  @override
  setPrintEnabled(bool printEnabled) {
    if (printEnabled) {
      bindings.VEnablePrint(ptr);
    } else {
      bindings.VDisablePrint(ptr);
    }
  }

  @override
  shareWithUsers(List<String> usersEmail) {
    final usersPtrList =
        usersEmail.map((user) => user.toNativeUtf8().cast<Char>()).toList();
    final Pointer<Pointer<Char>> usersPtr =
        calloc.allocate(usersPtrList.length);
    for (int i = 0; i < usersPtrList.length; i++) {
      usersPtr[i] = usersPtrList[i];
    }
    bindings.VShareWithUsers(ptr, usersPtr, usersPtrList.length);
  }

  @override
  removeUsers(List<String> usersEmail) {
    final usersPtrList =
        usersEmail.map((user) => user.toNativeUtf8().cast<Char>()).toList();
    final Pointer<Pointer<Char>> usersPtr =
        calloc.allocate(usersPtrList.length);
    for (int i = 0; i < usersPtrList.length; i++) {
      usersPtr[i] = usersPtrList[i];
    }
    bindings.VRemoveUsers(ptr, usersPtr, usersPtrList.length);
  }

  @override
  dispose() {
    bindings.VPolicyDestroy(ptr);
  }
}
