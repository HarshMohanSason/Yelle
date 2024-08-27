class TextFormValidator {

  static String? validateEmail(String? value) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (value!.isEmpty == true) {
      return 'Email cannot be empty';
    }
    if (value.isNotEmpty && !emailRegExp.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null; // Return null if the value is empty or valid
  }

  static String? validateOTP(String? value) {
    final nonNumericRegExp = RegExp(r'^[0-9]');
    if (value!.isEmpty == true) {
      return 'OTP cannot be empty';
    }
    //check if the number isWithin 0-9 and is lowercase
    else if (!nonNumericRegExp.hasMatch(value)) {
      return 'OTP can only contain digits';
      //return error if it doesn't match the REGEXP
    } else if (value.length < 6) {
      return 'OTP should be 6 digit number';
    }
    return null;
  }

  static String? validateName(String? value) {
    // Regular expression to allow only alphabets (A-Z, a-z) and spaces
    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!regex.hasMatch(value)) {
      return 'Name must contain only alphabets and spaces';
    } else if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    } else if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }
    return null; // Valid name
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // Minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must include at least one uppercase letter';
    }
    // Lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must include at least one lowercase letter';
    }
    // Numeric digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must include at least one number';
    }
    // Special character
    if (!RegExp(r'[!@#\$%\^&\*]').hasMatch(value)) {
      return 'Password must include at least one special character';
    }
    return null; // Password is valid
  }
}
