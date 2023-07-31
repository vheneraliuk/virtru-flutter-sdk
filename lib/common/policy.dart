import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/native_error.dart';
import 'package:virtru_sdk_flutter/policy.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter_bindings.dart';

class PolicyImpl implements Policy {
  final VPolicyPtr ptr;

  factory PolicyImpl() => PolicyImpl.fromPtr(bindings.VPolicyCreate());

  PolicyImpl.fromPtr(this.ptr);

  @override
  setOwner(String owner) {
    final status = bindings.VSetOwner(ptr, owner.toNativeUtf8().cast<Char>());
    _handleError(status);
  }

  @override
  String getOwner() {
    final owner = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final status = bindings.VGetOwner(ptr, owner);
    _handleError(status);
    final ownerEmail = owner.value.cast<Utf8>().toDartString();
    calloc.free(owner);
    return ownerEmail;
  }

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
    bindings.VAddExpiration(ptr, dateString.toNativeUtf8().cast<Char>());
  }

  @override
  DateTime? getExpirationDate() {
    final expirationTimeStamp =
        malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final status = bindings.VGetExpiration(ptr, expirationTimeStamp);
    _handleError(status);
    return DateTime.tryParse(
        expirationTimeStamp.value.cast<Utf8>().toDartString());
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
  bool isWatermarkEnabled() {
    final result = malloc.allocate<Int>(sizeOf<Int>());
    final status = bindings.VIsWatermarkingEnabled(ptr, result);
    _handleError(status);
    return result.value == 1;
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
  bool isPersistentProtectionEnabled() {
    final result = malloc.allocate<Int>(sizeOf<Int>());
    final status = bindings.VIsPersistentProtection(ptr, result);
    _handleError(status);
    return result.value == 1;
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
  bool isPreventDownloadEnabled() {
    final result = malloc.allocate<Int>(sizeOf<Int>());
    final status = bindings.VIsPreventDownloadEnabled(ptr, result);
    _handleError(status);
    return result.value == 1;
  }

  @override
  setReshareEnabled(bool reshareEnabled) {
    if (reshareEnabled) {
      bindings.VEnableReshare(ptr);
    } else {
      bindings.VDisableReshare(ptr);
    }
  }

  @override
  isReshareEnabled() {
    final result = malloc.allocate<Int>(sizeOf<Int>());
    final status = bindings.VIsReshareEnabled(ptr, result);
    _handleError(status);
    return result.value == 1;
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
  bool isCopyEnabled() {
    final result = malloc.allocate<Int>(sizeOf<Int>());
    final status = bindings.VIsCopyEnabled(ptr, result);
    _handleError(status);
    return result.value == 1;
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
  bool isPrintEnabled() {
    final result = malloc.allocate<Int>(sizeOf<Int>());
    final status = bindings.VIsPrintEnabled(ptr, result);
    _handleError(status);
    return result.value == 1;
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
  List<String> getSharedUsers() {
    final users = malloc
        .allocate<Pointer<Pointer<Char>>>(sizeOf<Pointer<Pointer<Char>>>());
    final usersCount = malloc.allocate<UnsignedInt>(sizeOf<UnsignedInt>());
    final status = bindings.VGetSharedUsers(ptr, users, usersCount);
    _handleError(status);
    final sharedUsers = List<String>.empty(growable: true);
    for (int i = 0; i < usersCount.value; i++) {
      sharedUsers.add(users.value[i].cast<Utf8>().toDartString());
    }
    calloc.free(users);
    return sharedUsers;
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

  _handleError(int status) {
    switch (status) {
      case VSTATUS.VSTATUS_SUCCESS:
        return;
      case VSTATUS.VSTATUS_FAILURE:
        throw NativeError(status, "Native code failure");
      case VSTATUS.VSTATUS_INVALID_PARAMS:
        throw NativeError(status, "Invalid params");
    }
  }
}
