class Validator {
  String emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Username is required';
    } else if (value.trim().length < 3) {
      return 'Username should be atleast 3 characters';
    } else if (value.trim().length > 25) {
      return 'Username is too long';
    }
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.trim().length < 6) {
      return 'Password should be atleast 6 characters';
    }
    return null;
  }
}

class EmailValidator {
  String validate(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
