import 'package:flutter/material.dart';


import '../../app_utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  String hint;
  String? Function(String?)? validator;
  TextEditingController? controller ;


  AppTextField(this.hint,this.validator,{super.key,this.controller});

  @override
  Widget build(BuildContext context) {

    return   TextFormField(
      controller: controller,
validator: validator,

      decoration: InputDecoration(
   filled: true,
        fillColor: AppColors.whiteLightColor,

        hintText: hint,
        border:OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.blueColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ), 
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.blueColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.RedColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),

      ),
    );
  }
}
