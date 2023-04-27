import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../export.dart';

buildBottomSheetPickup(context, {required ValueChanged<File?> onPickFile}) async{
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          padding: const EdgeInsets.only(
            bottom: 15.0,
            left: 15.0,
            right: 15.0,
            top: 10.0,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Text("Selection une source"),
              const SpaceHeight(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        pickImage(
                            imageSource: ImageSource.gallery,
                            onChange: (file){
                              onPickFile(file);
                              Navigator.of(context).pop();
                            }
                        );
                      },
                      child: Column(
                        children: [
                          Icon(Icons.photo_library_outlined),
                          Text("Galerie")
                        ],
                      )),
                  InkWell(
                      onTap: () {
                        pickImage(
                            imageSource: ImageSource.camera,
                            onChange: (file){
                              onPickFile(file);
                              Navigator.of(context).pop();
                            }
                        );
                      },
                      child: Column(
                        children: [
                          Icon(Icons.camera),
                          Text("Caméra")
                        ],
                      )),
                ],
              )
            ],
          ),
        );
      });
}