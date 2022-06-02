extension Validator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidOTP() {
    return RegExp(r'^[0-9]{6}').hasMatch(this);
  }
}

extension Lim on String {
  String cutAtLength(int maxLen) {
    if (length > maxLen) {
      return replaceRange(maxLen - 3, length, '...');
    } else {
      return this;
    }
  }
}
