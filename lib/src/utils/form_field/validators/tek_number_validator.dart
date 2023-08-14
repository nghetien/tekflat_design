import 'package:flutter/material.dart';

import './tek_validator_mess_error.dart';
import '../formatters/formatters.dart';
import '../value_transformer/value_transformer.dart';

class TekNumberValidator {
  const TekNumberValidator._();

  static FormFieldValidator<String> greaterThanTo(num value, {String? errorText}) =>
      (valueCandidate) {
        if (valueCandidate == null || valueCandidate.isEmpty) return null;
        final valueCan = TekNumberTransformer.currencyToNumber(valueCandidate) ?? 0;
        if (valueCan < value) {
          return errorText ??
              TekFormValidatorMessageError()
                  .largeThan
                  ?.call(valueCandidate);
        }
        return null;
      };

  static FormFieldValidator<String> greaterThanOrEqualTo(num value, {String? errorText}) =>
      (valueCandidate) {
        if (valueCandidate == null || valueCandidate.isEmpty) return null;
        final valueCan = TekNumberTransformer.currencyToNumber(valueCandidate) ?? 0;
        if (valueCan <= value) {
          return errorText ??
              TekFormValidatorMessageError()
                  .largeThan
                  ?.call(valueCandidate);
        }
        return null;
      };

  static FormFieldValidator<String> lessThanTo(num value, {String? errorText}) => (valueCandidate) {
        if (valueCandidate == null || valueCandidate.isEmpty) return null;
        final valueCan = TekNumberTransformer.currencyToNumber(valueCandidate) ?? 0;
        if (valueCan > value) {
          return errorText ??
              TekFormValidatorMessageError()
                  .lessThan
                  ?.call(valueCandidate);
        }
        return null;
      };

  static FormFieldValidator<String> lessThanOrEqualTo(num value, {String? errorText}) =>
      (valueCandidate) {
        if (valueCandidate == null || valueCandidate.isEmpty) return null;
        final valueCan = TekNumberTransformer.currencyToNumber(valueCandidate) ?? 0;
        if (valueCan >= value) {
          return errorText ??
              TekFormValidatorMessageError()
                  .lessThan
                  ?.call(valueCandidate);
        }
        return null;
      };
}
