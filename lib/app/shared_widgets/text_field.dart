
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';


class InputTextField extends StatefulWidget {
  final String hint;
  final String? errorText;
  final bool readOnly;
  final bool? isError;
  final bool? obscureText;
  final Color? clr;
  final int? lines;
  final int? length;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController ctrl;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChange;
  final Widget? icon; // Left-side icon (optional)

  InputTextField({
    required this.hint,
    this.inputFormatters,
    this.obscureText,
    required this.ctrl,
    this.validator,
    required this.keyboardType,
    required this.readOnly,
    this.onChange,
    this.clr,
    this.lines,
    this.length,
    this.errorText,
    this.isError,
    this.icon, // Add the icon parameter
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.clr ?? Colors.white, // Default background color is white.
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners.
        border: Border.all(
          color: widget.isError == true ? Colors.red : Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        controller: widget.ctrl,
        readOnly: widget.readOnly,
        obscureText: widget.obscureText ?? false,
        maxLines: widget.lines ?? 1,
        maxLength: widget.length,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          hintText: widget.hint,
          errorText: widget.errorText,
          border: InputBorder.none,
          counterText: '', // Hides the maxLength counter.
          prefixIcon: widget.icon, // Add the left-side icon here.
            contentPadding: widget.icon == null
                ? const EdgeInsets.fromLTRB(12, 14, 12, 14)
                : const EdgeInsets.symmetric(vertical: 14),
        ),
        validator: widget.validator,
        onChanged: widget.onChange,
        style: const TextStyle(
          color: Colors.black, // Text color.
        ),
      ),
    );
  }
}


class DashboardInputTextField extends StatefulWidget {
  final String hint;
  final Widget? icon;
  final String? errorText;
  final bool readOnly;
  final bool? isError;
  final Color? clr;
  final Color? borderClr;
  final int? lines;
  final int? length;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController ctrl;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChange;
  DashboardInputTextField( {required this.hint,this.inputFormatters ,required this.ctrl, this.validator, required this.keyboardType, required this.readOnly, this.onChange, this.clr, this.lines, this.length, this.errorText, this.isError, this.borderClr, this.icon,});

  @override
  State<DashboardInputTextField> createState() => _DashboardInputTextFieldState();
}

class _DashboardInputTextFieldState extends State<DashboardInputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength:widget.length ,
      onChanged: widget.onChange,
      readOnly:widget.readOnly ,
      controller:widget.ctrl ,
      inputFormatters: widget.inputFormatters ?? [],
      keyboardType:widget.keyboardType ,
      validator:widget.validator ,
      cursorColor:AppColors.primary ,
      maxLines: widget.lines,
      style: AppTextStyles.dashboardHeading.copyWith(color: AppColors.darkPrimary,fontSize: 14),
      decoration: InputDecoration(
        hintText: widget.hint ,
        suffixIcon: widget.icon,
        counterText: '',
        errorText:widget.errorText,
        contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        fillColor:widget.clr ?? AppColors.trans,
        filled: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:widget.ctrl.text.isEmpty? AppColors.white:AppColors.tertiaryOrange,width: 1),
            borderRadius: BorderRadius.circular(8)),
        hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.darkPrimary.withOpacity(0.60)),
        focusedBorder: OutlineInputBorder( borderSide: BorderSide(color:widget.borderClr??AppColors.primary,width: 1),
            borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: OutlineInputBorder( borderSide: BorderSide(color:widget.borderClr??AppColors.primary,width: 1),
            borderRadius: BorderRadius.circular(8)),
        errorBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.red,width: 1),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class InputPasswordField extends StatefulWidget {
  final String hint;
  final bool readOnly;
  final bool obSecure;
  final List<TextInputFormatter>? inputFormatters;
  final IconButton eye;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextEditingController ctrl;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChange;
 const InputPasswordField( {super.key, this.focusNode,this.inputFormatters, required this.hint, required this.ctrl, this.validator, required this.keyboardType, required this.readOnly, this.onChange, required this.eye, required this.obSecure,});

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      obscureText: widget.obSecure,
      onChanged: widget.onChange,
      readOnly:widget.readOnly ,
      controller:widget.ctrl ,
      inputFormatters: widget.inputFormatters,
      keyboardType:widget.keyboardType ,
      validator:widget.validator ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor:AppColors.primary ,
      decoration: InputDecoration(
        suffixIcon: widget.eye,
        hintText: widget.hint ,
        contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        fillColor: AppColors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(borderSide:const BorderSide(color:AppColors.white,width: 1),
        borderRadius: BorderRadius.circular(8)),
        errorBorder: OutlineInputBorder(borderSide:const BorderSide(color:AppColors.red,width: 1),
        borderRadius: BorderRadius.circular(8)),
        hintStyle: AppTextStyles.hintText,
        errorStyle:const TextStyle(color: AppColors.red), focusedErrorBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
        borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
        borderRadius: BorderRadius.circular(8))
      ),
    );
  }
}

class DropdownInput extends StatelessWidget {
  final String hint;
  final Color? clr;
  final String value;
  final List<String> list;
  final void Function(String?)? onChanged;
  const DropdownInput({super.key, required this.hint, required this.list, required this.value, this.onChanged, this.clr});
  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField(
      value:value ,
      items:list.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
      icon:const Icon(Icons.keyboard_arrow_down,color: AppColors.grey,),
      style:const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.hintColor),
      decoration: InputDecoration(
          hintText: hint ,
          contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          fillColor:clr ?? AppColors.white,
          filled: true,
          hintStyle: AppTextStyles.hintText,
          enabledBorder: OutlineInputBorder(
              borderSide:const BorderSide(color:AppColors.white,width: 1),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
              borderRadius: BorderRadius.circular(8))
      ),
    );
  }
}

class InputEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String)? onChanged;

  const InputEmailField({
    super.key,
    required this.controller,
    this.hintText = "Enter your email",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: "Email",
        filled: true,
        fillColor: AppColors.white,
        hintText: hintText,
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }
}