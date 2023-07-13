class TekFormValidatorMessageError {
  TekFormValidatorMessageError._privateConstructor();

  static final TekFormValidatorMessageError _instance =
  TekFormValidatorMessageError._privateConstructor();

  factory TekFormValidatorMessageError() => _instance;

  String _email = 'Email is empty or invalid';
  String _required = 'This field is required';
  String Function(Object)? _equal = (Object value) => 'Value must be equal to $value';
  String Function(Object)? _notEqual = (Object value) => 'Value must not be equal to $value';
  String Function(String)? _min = (String min) => 'Value must be greater than $min';
  String Function(String)? _max = (String max) => 'Value must be less than $max';
  String Function(int)? _minLength =
      (int minLength) => 'Value must be at least $minLength characters';
  String Function(int)? _maxLength =
      (int maxLength) => 'Value must be at most $maxLength characters';
  String Function(int)? _equalLength = (int length) => 'Value must be $length characters';
  String _url = 'Value must be a valid URL';
  String Function(String)? _match = (String pattern) => 'Value must match the pattern $pattern';
  String _numeric = 'Value must be numeric';
  String _integer = 'Value must be an integer';
  String _creditCard = 'Value must be a valid credit card number';
  String _ip = 'Value must be a valid IP address';
  String _dateTime = 'Value must be a valid date';
  String _timeOfDay = 'Value must be a valid time of day';
  String _phone = 'Value must be a valid phone';

  String get email => _email;

  String get required => _required;

  String Function(Object)? get equal => _equal;

  String Function(Object)? get notEqual => _notEqual;

  String Function(String)? get min => _min;

  String Function(String)? get max => _max;

  String Function(int)? get minLength => _minLength;

  String Function(int)? get maxLength => _maxLength;

  String Function(int)? get equalLength => _equalLength;

  String get url => _url;

  String Function(String)? get match => _match;

  String get numeric => _numeric;

  String get integer => _integer;

  String get creditCard => _creditCard;

  String get ip => _ip;

  String get dateTime => _dateTime;

  String get timeOfDay => _timeOfDay;

  String get phone => _phone;

  void setEmail(String value) => _email = value;

  void setRequired(String value) => _required = value;

  void setEqual(String Function(Object)? value) => _equal = value;

  void setNotEqual(String Function(Object)? value) => _notEqual = value;

  void setMin(String Function(String)? value) => _min = value;

  void setMax(String Function(String)? value) => _max = value;

  void setMinLength(String Function(int)? value) => _minLength = value;

  void setMaxLength(String Function(int)? value) => _maxLength = value;

  void setEqualLength(String Function(int)? value) => _equalLength = value;

  void setUrl(String value) => _url = value;

  void setMatch(String Function(String)? value) => _match = value;

  void setNumeric(String value) => _numeric = value;

  void setInteger(String value) => _integer = value;

  void setCreditCard(String value) => _creditCard = value;

  void setIp(String value) => _ip = value;

  void setDateTime(String value) => _dateTime = value;

  void setTimeOfDay(String value) => _timeOfDay = value;

  void setPhone(String value) => _phone = value;
}