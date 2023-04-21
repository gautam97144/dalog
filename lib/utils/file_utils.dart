part of 'utils.dart';

class FileUtils {
  FileUtils._();

  static final ImagePicker _picker = ImagePicker();

  static pickImage(ImageSource source) async {
    try {
      XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<DateTime?> pickDate(BuildContext context) async {
    final DateTime? selectedTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primaryColor: AppColor.primaryColor,
              colorScheme:
                  const ColorScheme.light(primary: AppColor.primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        });
    if (selectedTime != null) {
      return selectedTime;
    } else {
      return null;
    }
  }

  static pickTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Theme(
              data: ThemeData(
                primaryColor: AppColor.primaryColor,
                colorScheme:
                    const ColorScheme.light(primary: AppColor.primaryColor),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child ?? const SizedBox.shrink(),
            ),
          );
        });
    if (timeOfDay != null) {
      return timeOfDay;
    } else {
      return null;
    }
  }

  static Future permissionHanDle(int? index) async {
    Map<Permission, PermissionStatus> status =
        await [Permission.camera, Permission.storage].request();
    if (status[Permission.camera]!.isGranted && index == 1) {
      return FileUtils.pickImage(ImageSource.camera);
    }
    if (status[Permission.storage]!.isGranted && index == 2) {
      return FileUtils.pickImage(ImageSource.gallery);
    }
    return status;
  }

  static getFormatDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('MMM dd, yyyy');
    var newDate = outputFormat.format(inputDate);
    return newDate;
  }
}
