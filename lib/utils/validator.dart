
class Validator {
  static String validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  static String validateName(String value) {
   Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
   RegExp regex = new RegExp(pattern);
   if (!regex.hasMatch(value))
      return 'Please enter a name';
    else
      return null;
  }

  static String validateNumber(String value) {
    Pattern pattern = r'(^[0-9]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid phone number';
    else
      return null;
  }

  static String validateMobile(String value) {

    if (value.length!=10)
      return 'Enter Valid phone number';
    else
      return null;
  }

}
