import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:permission_handler/permission_handler.dart';

class ImageInput extends StatefulWidget {
  final Function? onSelectImage;

  const ImageInput({Key? key, this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
    } else if (status == PermissionStatus.denied) {
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }

  _takePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return null;
    }

    requestCameraPermission();
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String? fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage!(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('Nenhuma imagem'),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextButton.icon(
                onPressed: _takePicture,
                label: const Text('Tirar Foto'),
                icon: const Icon(Icons.camera))),
      ],
    );
  }
}
