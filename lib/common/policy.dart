import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:virtru_sdk/common/client.dart';
import 'package:virtru_sdk/common/encrypt_params.dart';
import 'package:virtru_sdk/native_error.dart';
import 'package:virtru_sdk/policy.dart';
import 'package:virtru_sdk/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk/virtru_sdk_bindings.dart';

class PolicyImpl implements Policy {
  final VPolicyPtr ptr;

  factory PolicyImpl() => PolicyImpl.fromPtr(bindings.VPolicyCreate());

  PolicyImpl.fromPtr(this.ptr);

  @override
  setOwner(String owner) {
    final status = bindings.VSetOwner(ptr, owner.toNativeString());
    _handleError(status);
  }

  @override
  String getOwner() {
    final owner = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final status = bindings.VGetOwner(ptr, owner);
    _handleError(status);
    final ownerEmail = owner.toDartString();
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
    bindings.VAddExpiration(ptr, dateString.toNativeString());
  }

  @override
  DateTime? getExpirationDate() {
    final expirationTimeStamp =
        malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final status = bindings.VGetExpiration(ptr, expirationTimeStamp);
    _handleError(status);
    return DateTime.tryParse(expirationTimeStamp.toDartString());
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
    bindings.VShareWithUsers(ptr, usersEmail.toNativeList(), usersEmail.length);
  }

  @override
  List<String> getSharedUsers() {
    final users = malloc
        .allocate<Pointer<Pointer<Char>>>(sizeOf<Pointer<Pointer<Char>>>());
    final usersCount = malloc.allocate<UnsignedInt>(sizeOf<UnsignedInt>());
    final status = bindings.VGetSharedUsers(ptr, users, usersCount);
    _handleError(status);
    final sharedUsers = users.toDartList(usersCount.value);
    calloc.free(users);
    return sharedUsers;
  }

  @override
  removeUsers(List<String> usersEmail) {
    bindings.VRemoveUsers(ptr, usersEmail.toNativeList(), usersEmail.length);
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

extension DartConverter on Pointer<Pointer<Pointer<Char>>> {
  List<String> toDartList(int length) {
    final stringList = List<String>.empty(growable: true);
    for (int i = 0; i < length; i++) {
      stringList.add(value[i].toDartString());
    }
    return stringList;
  }
}
