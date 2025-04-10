import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImageData extends Equatable {
  final String link;
  final Uint8List? byte;
  final XFile? file;

  bool get exist => link.isNotEmpty || byte != null || file != null;

  const ImageData({this.link = "", this.byte, this.file});

  ImageData copyWith({String? link, Uint8List? byte, XFile? file}) {
    return ImageData(
      link: link ?? this.link,
      byte: byte ?? this.byte,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [link, byte, file];

  @override
  bool get stringify => true;
}
