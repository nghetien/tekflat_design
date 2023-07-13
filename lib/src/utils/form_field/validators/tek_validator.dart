import 'package:flutter/material.dart';

import './tek_date_time_validator.dart';
import './tek_validator_mess_error.dart';

class TekFormValidator {
  const TekFormValidator._();

  static FormFieldValidator<String> dateTime({String? errorText, String? validator}) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !TekDateTimeValidator.isDateTime(
                valueCandidate!,
                validator: validator,
              )
          ? errorText ?? TekFormValidatorMessageError().dateTime
          : null;

  static FormFieldValidator<String> timeOfDay({String? errorText}) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !TekDateTimeValidator.isTimeOfDay(
                valueCandidate!,
              )
          ? errorText ?? TekFormValidatorMessageError().timeOfDay
          : null;
}
