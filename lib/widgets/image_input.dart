import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  Function? onSelectedImage;

   ImageInput({Key? key, this.onSelectedImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    ImagePicker? _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
        source: ImageSource.camera, maxWidth: 600) as XFile;

    if (imageFile == null) {
      return null;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    // widget.onSelectedImage!(...);
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
