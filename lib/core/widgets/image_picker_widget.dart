// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fortuno/core/core.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerResult {
  final Uint8List imageByte;
  final XFile file;

  ImagePickerResult({required this.imageByte, required this.file});
}

class ImagePickerWidget extends StatefulWidget {
  final Future<void> Function(ImagePickerResult image) onChange;

  const ImagePickerWidget({super.key, required this.onChange});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late ImagePicker imagePicker;
  XFile? file;
  Uint8List? byte;

  bool get isPicked => file != null && byte != null;

  @override
  initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> selectImageFromGallery() async {
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      EasyLoading.showToast("Batal mengambil gambar");
      return;
    }

    final byte = await file.readAsBytes();
    final imageResult = ImagePickerResult(imageByte: byte, file: file);

    await widget.onChange(imageResult);

    setState(() {
      this.file = file;
      this.byte = byte;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(kDefaultRadius),
      padding: EdgeInsets.all(kSizeSS),
      color: lightGrey3,
      child: InkWell(
        onTap: () async {
          await selectImageFromGallery();
        },
        borderRadius: BorderRadius.circular(kDefaultRadius * 0.8),
        child: Ink(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: lightGrey5,
            borderRadius: BorderRadius.circular(kDefaultRadius * 0.8),
          ),
          child:
              !isPicked
                  ? Center(
                    child: Text(
                      "Upload Gambar",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: lightGrey2,
                      ),
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(kDefaultRadius * 0.8),
                    child: Image.memory(byte!, fit: BoxFit.cover),
                  ),
        ),
      ),
    );
  }
}
