import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files.single.name;
    } else {
      // User canceled the picker
      return null;
    }
  }
}
