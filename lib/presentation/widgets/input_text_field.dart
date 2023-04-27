import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../export.dart';

class InputTextField extends StatefulWidget {
  final String? label;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final String? hintText;
  final String? error;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxline;
  final int? minline;
  final bool? isPassword;
  final bool? isSuffixIcon;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixWidget;
  final String? initialValue;

  const InputTextField({
    Key? key,
    this.label,
    this.hintText,
    this.readOnly = false,
    required this.onChanged,
    required this.keyboardType,
    this.error,
    this.inputFormatters,
    this.controller,
    this.maxline,
    this.minline,
    this.isPassword,
     this.isSuffixIcon,
     this.initialValue,
    this.obscureText = false,
    this.suffixWidget,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => InputTextFieldState();
}

class InputTextFieldState extends State<InputTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();

    if (widget.isPassword == null) {
      _obscureText = false;
    } else {
      _obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: kSubtitle1,
        ),
        const SpaceHeight(10),
       TextFormField(
              onChanged: widget.onChanged,
              cursorColor: AppColors.primary,
              controller: widget.controller,
              initialValue: widget.initialValue,
              keyboardType: widget.keyboardType==TextInputType.number? const TextInputType.numberWithOptions(
              signed: true, decimal: true):widget.keyboardType,
              textInputAction: TextInputAction.done,
              maxLines: widget.maxline??1,
              readOnly: widget.readOnly,
              inputFormatters: widget.inputFormatters,
              minLines: widget.minline??null,
              decoration:  InputDecoration(
                  //border: InputBorder.none,
                  enabledBorder:  OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderRadius: BorderRadius.circular(RadiusSizes.r10),
                    borderSide: const BorderSide(color:AppColors.grey,),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(RadiusSizes.r10), ),
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.only(left: 25, top: 17, bottom: 17),
                  hintStyle: kSubtitle1.copyWith(color: AppColors.black.withOpacity(0.6)),
                  suffixIcon: widget.isSuffixIcon??false? widget.suffixWidget:null
              ),
              obscuringCharacter:"●",
              obscureText: widget.obscureText,

            ),
        widget.error == null
            ? Container()
            : Text(
          "${widget.error}",
          style: kSubtitle1.copyWith(color: AppColors.error),
        )
      ],
    );
  }
}
