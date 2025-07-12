import 'package:clothing/shared/firebase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImage {
  final String name;
  final String? extention;
  final Uint8List uInt8List;

  SelectedImage({
    required this.name,
    required this.uInt8List,
    required this.extention,
  });
}

class ImagePickerService {
  Future<List<SelectedImage>> pickImageAndCompress({
    required bool useCompressor,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        final imgs = <SelectedImage>[];
        for (var e in result.files) {
          final finalBytes =
              useCompressor ? await imageCompressor(e.bytes!) : e.bytes!;
          imgs.add(
            SelectedImage(
              name: e.name,
              extention: e.extension!,
              uInt8List: finalBytes,
            ),
          );
        }
        return imgs;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<SelectedImage?> pickPdfFile(
    BuildContext context, {
    required bool useCompressor,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        SelectedImage? pickedFile;
        for (var e in result.files) {
          final finalBytes =
              useCompressor ? await imageCompressor(e.bytes!) : e.bytes!;
          pickedFile = SelectedImage(
            name: e.name,
            extention: e.extension!,
            uInt8List: finalBytes,
          );

          // imgs.add(SelectedImage(
          //     name: e.name, extention: e.extension!, uInt8List: finalBytes));
        }
        return pickedFile;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<SelectedImage>> pickImageAndCrop(
    BuildContext context, {
    required bool useCompressor,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        final imgs = <SelectedImage>[];
        for (var e in result.files) {
          final finalBytes =
              useCompressor ? await imageCompressor(e.bytes!) : e.bytes!;
          imgs.add(
            SelectedImage(
              name: e.name,
              extention: e.extension!,
              uInt8List: finalBytes,
            ),
          );
        }
        return imgs;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<SelectedImage?> pickImageNew(
    BuildContext context, {
    required bool useCompressor,
  }) async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        final nameSplits = image.name.split(".");

        final finalBytes =
            useCompressor
                ? await imageCompressor(await image.readAsBytes())
                : await image.readAsBytes();
        return SelectedImage(
          name: nameSplits.first,
          extention: nameSplits.length > 1 ? nameSplits.last : "",
          uInt8List: finalBytes,
        );
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      // showAppSnack(e.toString());
      Clipboard.setData(ClipboardData(text: e.toString()));
      return null;
    }
  }
}

Future<Uint8List> imageCompressor(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 1920,
    minWidth: 1080,
    quality: 70,
  );
  return result;
}

Future<String?> uploadGalleryFiles(SelectedImage imageFile) async {
  try {
    final imageRef = FBStorage.images.child(
      '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}',
    );
    final task = await imageRef.putData(imageFile.uInt8List);
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
