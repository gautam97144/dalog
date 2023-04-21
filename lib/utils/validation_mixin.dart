part of 'utils.dart';

mixin ValidationMixin {
  String? firstNameValidator(String? firstName) {
    if (firstName!.isNotEmpty) {
      return null;
    } else {
      return 'Please enter first name';
    }
  }

  String? lastNameValidator(String? lastName) {
    if (lastName!.isNotEmpty) {
      return null;
    } else {
      return 'Please enter last name';
    }
  }

  String? emailValidator(String? email, {bool isLogin = false}) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    if (email!.isNotEmpty) {
      if (isLogin == false) {
        if (regex.hasMatch(email)) {
          return null;
        } else {
          return "Please enter valid email";
        }
      }
      return null;
    } else {
      return "Please enter your email";
    }
  }

  String? mobileNumberValidator(String? mobileNumber) {
    if (mobileNumber!.isNotEmpty) {
      return null;
    } else {
      return "Please enter mobile Number";
    }
  }

  String? passwordValidator(String? password, {bool isLogin = false}) {
    if (password!.isNotEmpty) {
      if (isLogin == false) {
        if (password.length < 6) {
          return "Password is too short";
        }
      }
      return null;
    } else {
      return "please enter your password";
    }
  }

  String? confirmPasswordValidator(String value, String? password) {
    if (password!.isNotEmpty) {
      if (value != password) {
        return 'Password does not match';
      }
      return null;
    } else {
      return "please enter your password";
    }
  }

  String? oldPasswordValidator(String? oldPassword) {
    if (oldPassword!.isNotEmpty) {
      return null;
    } else {
      return "Please enter old password";
    }
  }

  // ======= create job ========= //

  String? jobTitleValidation(String? jobtitle) {
    if (jobtitle!.isNotEmpty) {
      return null;
    } else {
      return "Please enter enter jobtitle";
    }
  }

  String? pickUpLocationValidation(String? pickupLocation) {
    if (pickupLocation!.isNotEmpty) {
      return null;
    } else {
      return "Please enter pickup location";
    }
  }

  String? dropOffUpLocationValidation(String? dropOffLocation) {
    if (dropOffLocation!.isNotEmpty) {
      return null;
    } else {
      return "Please enter drop off location";
    }
  }

  String? pickupDateValidation(String? pickupDate) {
    if (pickupDate!.isNotEmpty) {
      return null;
    } else {
      return "Please enter date";
    }
  }

  String? picupTimeValidation(String? pickupTime) {
    if (pickupTime!.isNotEmpty) {
      return null;
    } else {
      return "Please enter time";
    }
  }

  String? addressValidation(String? address) {
    if (address!.isNotEmpty) {
      return null;
    } else {
      return "Please enter address";
    }
  }

  String? cityValidation(String? city) {
    if (city!.isNotEmpty) {
      return null;
    } else {
      return "Please enter city";
    }
  }

  String? stateValidation(String? state) {
    if (state!.isNotEmpty) {
      return null;
    } else {
      return "Please enter state";
    }
  }

  String? zipCodeValidation(String? state) {
    if (state!.isNotEmpty) {
      return null;
    } else {
      return "Please enter zip code";
    }
  }

  String? countryValidation(String? state) {
    if (state!.isNotEmpty) {
      return null;
    } else {
      return "Please enter country";
    }
  }

  String? totalValue(String? totalValue) {
    if (totalValue!.isNotEmpty) {
      return null;
    } else {
      return "Please enter total item cost";
    }
  }

  String? estimatedCost(String? estimatedCost) {
    if (estimatedCost!.isNotEmpty) {
      return null;
    } else {
      return "Please enter estimated cost";
    }
  }

  String? serviceFees(String? serviceFees) {
    if (serviceFees!.isNotEmpty) {
      return null;
    } else {
      return "Please enter estimated cost";
    }
  }

  String? itemNameValidation(String? itemName) {
    if (itemName!.isNotEmpty) {
      return null;
    } else {
      return "Please enter itemname";
    }
  }

  String? quantityValidation(String? quantity) {
    if (quantity!.isNotEmpty) {
      return null;
    } else {
      return "Please enter quantity";
    }
  }
}
