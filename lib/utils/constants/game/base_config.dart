import 'package:flutter/material.dart';

/// Base class for all game configurations
abstract class BaseGameConfig {
  /// Creates a base game configuration
  const BaseGameConfig();

  /// Creates a copy of this configuration with some properties replaced
  BaseGameConfig copyWith();

  /// Validates the configuration values
  bool validate() => true;

  /// Provides a string representation of the configuration
  @override
  String toString() {
    return '$runtimeType()';
  }

  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseGameConfig && runtimeType == other.runtimeType;
  }

  /// Hash code
  @override
  int get hashCode => runtimeType.hashCode;
}

/// Mixin for configurations that can be serialized to/from JSON
mixin JsonSerializable {
  /// Converts the configuration to a JSON map
  Map<String, dynamic> toJson();

  /// Creates a configuration from a JSON map
  static T fromJson<T>(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson() has not been implemented.');
  }
}

/// Mixin for configurations that support validation
mixin Validatable {
  /// List of validation errors
  List<String> get validationErrors;

  /// Whether the configuration is valid
  bool get isValid => validationErrors.isEmpty;

  /// Validates the configuration and returns true if valid
  bool validate() {
    return isValid;
  }
}

/// Mixin for configurations that support interpolation
mixin Interpolatable<T> {
  /// Linearly interpolates between two configurations
  T lerp(T other, double t);

  /// Creates a configuration with default values
  T get defaultValue;
}
