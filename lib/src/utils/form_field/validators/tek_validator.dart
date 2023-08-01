import 'package:flutter/material.dart';

import './tek_validator_mess_error.dart';

class TekFormValidator {
  const TekFormValidator._();

  static FormFieldValidator<DateTime> dateTime({String? errorText}) => (valueCandidate) =>
      valueCandidate != null ? errorText ?? TekFormValidatorMessageError().dateTime : null;

  static FormFieldValidator<DateTime> timeOfDay({String? errorText}) => (valueCandidate) =>
      valueCandidate != null ? errorText ?? TekFormValidatorMessageError().timeOfDay : null;
}
