import 'package:flutter/material.dart';

import '../../export.dart';

class PhoneNumberdInput extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? error;
  final EdgeInsets edgeInsets;
  final TextEditingController? textEditingController;
  final ValueChanged<CountryCode?>? onChanged;
   String code;

  PhoneNumberdInput({
  Key? key,
  this.label,
  this.hintText,
  this.error,
  this.textEditingController,
  this.onChanged,
  this.code = "BJ",
  this.edgeInsets = const EdgeInsets.only(left: 29, right: 29),
  }) : super(key: key);

  @override
  State<PhoneNumberdInput> createState() => PhoneNumberdInputdState();
}

class PhoneNumberdInputdState extends State<PhoneNumberdInput> {

  @override
  Widget build(BuildContext context) {
    CountryCode countryCode = CountryCode(name: "Benin", code: widget.code, dialCode: "+229");
    return Padding(
        padding:widget.edgeInsets ,child:BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.phonenumber != current.phonenumber,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            widget.label!,
            style: kSubtitle1,
          ),
          const SpaceHeight(10),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.primary,
                      controller:widget.textEditingController,
                      onChanged: (value)=>context.read<SignupCubit>().phoneNumberChanged(value, countryCode),
                      decoration: InputDecoration(
                        prefixIcon: CountryPick(
                          theme: CountryTheme(
                            isShowFlag: true,
                            isShowTitle: false,
                            isShowCode: true,
                            isDownIcon: true,
                            showEnglishName: true,
                          ),
                          initialSelection: CountryCode(name: "", code: widget.code, dialCode: "").code,
                          onChanged: (CountryCode? code) {
                            countryCode = code??CountryCode(name: "Bénin", code: widget.code, dialCode: "+229");
                            context.read<SignupCubit>().countryCodeChanged(countryCode);
                            setState(() {
                              if(widget.onChanged!=null){
                                widget.onChanged!(countryCode);
                              }
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(RadiusSizes.r10),
                          borderSide: const BorderSide(color: AppColors.grey,),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(RadiusSizes.r10),
                        ),
                        hintText: widget.hintText,
                        contentPadding: const EdgeInsets.only(left: 25, top: 17, bottom: 17),
                        hintStyle: kSubtitle1.copyWith(color: AppColors.black.withOpacity(0.6)),
                      ),
                    ))
              ],
            ),
          ),
          !state.phonenumber.invalid ? Container()
              : Text("Champs requis",
            style: kSubtitle1.copyWith(color: AppColors.error),),
        ],);
      },
    ));
  }
}
