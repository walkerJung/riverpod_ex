// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_generation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gStateHash() => r'7ccdacb016fab2894413745b936f82987f9f72cf';

/// See also [gState].
@ProviderFor(gState)
final gStateProvider = AutoDisposeProvider<String>.internal(
  gState,
  name: r'gStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GStateRef = AutoDisposeProviderRef<String>;
String _$gStateFutureHash() => r'eef3e95f799e15b4647a3851f8ee6b4438b05afa';

/// See also [gStateFuture].
@ProviderFor(gStateFuture)
final gStateFutureProvider = AutoDisposeFutureProvider<int>.internal(
  gStateFuture,
  name: r'gStateFutureProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gStateFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GStateFutureRef = AutoDisposeFutureProviderRef<int>;
String _$gStateFuture2Hash() => r'c346965a30436f2ab0f038c27592f51d26b2d4bb';

/// See also [gStateFuture2].
@ProviderFor(gStateFuture2)
final gStateFuture2Provider = FutureProvider<int>.internal(
  gStateFuture2,
  name: r'gStateFuture2Provider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gStateFuture2Hash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GStateFuture2Ref = FutureProviderRef<int>;
String _$gStateMultyplyHash() => r'caf4e1a49743cac941df6fc717fadfa0abfcb1f2';

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

typedef GStateMultyplyRef = AutoDisposeProviderRef<int>;

/// See also [gStateMultyply].
@ProviderFor(gStateMultyply)
const gStateMultyplyProvider = GStateMultyplyFamily();

/// See also [gStateMultyply].
class GStateMultyplyFamily extends Family<int> {
  /// See also [gStateMultyply].
  const GStateMultyplyFamily();

  /// See also [gStateMultyply].
  GStateMultyplyProvider call({
    required int number1,
    required int number2,
  }) {
    return GStateMultyplyProvider(
      number1: number1,
      number2: number2,
    );
  }

  @override
  GStateMultyplyProvider getProviderOverride(
    covariant GStateMultyplyProvider provider,
  ) {
    return call(
      number1: provider.number1,
      number2: provider.number2,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'gStateMultyplyProvider';
}

/// See also [gStateMultyply].
class GStateMultyplyProvider extends AutoDisposeProvider<int> {
  /// See also [gStateMultyply].
  GStateMultyplyProvider({
    required this.number1,
    required this.number2,
  }) : super.internal(
          (ref) => gStateMultyply(
            ref,
            number1: number1,
            number2: number2,
          ),
          from: gStateMultyplyProvider,
          name: r'gStateMultyplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gStateMultyplyHash,
          dependencies: GStateMultyplyFamily._dependencies,
          allTransitiveDependencies:
              GStateMultyplyFamily._allTransitiveDependencies,
        );

  final int number1;
  final int number2;

  @override
  bool operator ==(Object other) {
    return other is GStateMultyplyProvider &&
        other.number1 == number1 &&
        other.number2 == number2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number1.hashCode);
    hash = _SystemHash.combine(hash, number2.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
