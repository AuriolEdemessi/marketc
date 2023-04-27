import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage({required ImageSource imageSource, required ValueChanged<File?> onChange}) async{

  final pickedImage = await ImagePicker().pickImage(source: imageSource);

  onChange((pickedImage != null ? File(pickedImage.path) : null));

}
