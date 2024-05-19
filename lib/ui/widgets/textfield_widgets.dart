import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;

  final TextInputType? inputType;

  final String hint;

  final int? borderRadius;

  final String? Function(String?)? validator;

  final void Function(String?)? onChange;

  final bool? isPassword;

  final bool? isObscure;

  final bool? isVisibilityIconShow;

  final IconData? prefixIcon;

  final bool? readOnly;

  final List<TextInputFormatter>? textInputFormatters;

  final bool? isCircularBorder;

  final bool? reduceFieldPadding;

  const CustomTextField(
      {Key? key,
      required this.controller,
      this.inputType,
      required this.hint,
      this.borderRadius,
      this.validator,
      this.onChange,
      this.isPassword,
      this.isVisibilityIconShow,
      this.prefixIcon,
      this.isObscure,
      this.readOnly,
      this.textInputFormatters,
      this.isCircularBorder,
      this.reduceFieldPadding})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    _isObscure = widget.isObscure == true ? true : false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.textInputFormatters ?? [],
      readOnly: widget.readOnly == true ? true : false,
      cursorColor: Colors.black,
      controller: widget.controller,
      keyboardType: widget.inputType ?? TextInputType.text,
      textInputAction: TextInputAction.next,
      obscureText: _isObscure ? true : false,
      decoration: InputDecoration(
        contentPadding: widget.reduceFieldPadding == true
            ? EdgeInsets.symmetric(horizontal: 10, vertical: 5)
            : null,
        //fillColor: AppColors.textFieldColor,
        //filled: true,
        hintText: widget.hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black.withOpacity(0.4)),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: Colors.grey,
              )
            : null,
        suffixIcon: widget.isPassword == true
            ? widget.isVisibilityIconShow == true
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    child: Icon(
                      _isObscure == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  )
                : null
            : null,
        focusedBorder: widget.isCircularBorder == true
            ? OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.toDouble() ?? 8),
                borderSide: const BorderSide(color: Colors.grey, width: 0.5))
            : const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: widget.isCircularBorder == true
            ? OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.toDouble() ?? 8),
                borderSide: const BorderSide(color: Colors.grey, width: 0.5))
            : const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        errorBorder: widget.isCircularBorder == true
            ? OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.toDouble() ?? 8),
                borderSide:
                    BorderSide(color: Colors.red.withOpacity(0.7), width: 0.5))
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.red.withOpacity(0.7), width: 0.5)),
        focusedErrorBorder: widget.isCircularBorder == true
            ? OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.toDouble() ?? 8),
                borderSide:
                    BorderSide(color: Colors.red.withOpacity(0.7), width: 0.5))
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.red.withOpacity(0.7), width: 0.5)),
      ),
      onChanged: widget.onChange,
      validator: widget.validator,
    );
  }
}
