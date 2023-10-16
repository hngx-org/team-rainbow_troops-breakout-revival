import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.textEditingController,
      this.icon,
      this.enabled,
      this.onChanged,
      this.keyboardtype,
      this.hintText,
      this.obscuretext = false});

  final TextEditingController? textEditingController;
  final Widget? icon;
  final bool? enabled;
  final TextInputType? keyboardtype;
  final void Function(String)? onChanged;
  final String? hintText;
  final bool obscuretext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext,
      controller: textEditingController,
      cursorColor: Colors.black,
      keyboardType: keyboardtype,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          hintText: hintText,
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6AA4BA), width: 3.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          // focusedErrorBorder: UnderlineInputBorder(
          //   borderRadius: BorderRadius.circular(30.0),
          // ),
          // errorBorder: UnderlineInputBorder(
          //   borderRadius: BorderRadius.circular(30.0),
          // ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: icon,
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0)),
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enabled,
      // validator: (text) {
      //   if (text == null || text.isEmpty) {
      //     return "Text field can\'t be empty";
      //   }
      //   if (text.length < 4 || text.length > 49) {
      //     return "please enter a valid response";
      //   }
      // },
    );
  }
}
