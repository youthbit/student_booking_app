// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_calendar_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$remoteCalendarRepositoryHash() =>
    r'6ed7bc6938fcd97fbd2120d8d4202b2e73b3ac67';

/// See also [remoteCalendarRepository].
final remoteCalendarRepositoryProvider =
    AutoDisposeProvider<RemoteCalendarRepository>(
  remoteCalendarRepository,
  name: r'remoteCalendarRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteCalendarRepositoryHash,
);
typedef RemoteCalendarRepositoryRef
    = AutoDisposeProviderRef<RemoteCalendarRepository>;
String _$remoteCalendarFutureHash() =>
    r'944af9be0e547360a32d328393e27bda04f55612';

/// See also [remoteCalendarFuture].
final remoteCalendarFutureProvider = AutoDisposeFutureProvider<List<Event>>(
  remoteCalendarFuture,
  name: r'remoteCalendarFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteCalendarFutureHash,
);
typedef RemoteCalendarFutureRef = AutoDisposeFutureProviderRef<List<Event>>;
