import '../resources.dart';

abstract class FieldValidator {
  const FieldValidator();
}

class ValidField implements FieldValidator {
  const ValidField();
}

class EmptyField implements FieldValidator {
  const EmptyField();
}

class InvalidName implements FieldValidator {
  const InvalidName();
}

class InvalidEmail implements FieldValidator {
  const InvalidEmail();
}

class InvalidId implements FieldValidator {
  const InvalidId();
}

class InvalidMessage implements FieldValidator {
  const InvalidMessage();
}

class Validators {
  Validators._internal();

  static FieldValidator nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return const EmptyField();
    } else if (!RegexUtils.fullNameRegex.hasMatch(name.trim())) {
      return const InvalidName();
    }
    return const ValidField();
  }

  static FieldValidator emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return const EmptyField();
    } else if (!RegexUtils.emailRegex.hasMatch(email)) {
      return const InvalidEmail();
    }
    return const ValidField();
  }

  static FieldValidator idValidator(String? id) {
    if (id == null || id.isEmpty) {
      return const EmptyField();
    } else {
      int? integerid = int.tryParse(id);
      if (integerid == null) {
        return const InvalidId();
      }
      return integerid > 0 ? const ValidField() : const InvalidId();
    }
  }

  static FieldValidator messageValidator(String? message) {
    if (message == null || message.trim().isEmpty) {
      return const EmptyField();
    } else {
      return const ValidField();
    }
  }
}
