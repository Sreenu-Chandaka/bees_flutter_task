import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files.single.name;
    } else {
      return null;
    }
  }
}
