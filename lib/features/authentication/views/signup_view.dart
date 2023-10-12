import 'package:brick_breaker/features/authentication/viewmodels/authentication_view_model.dart';
import 'package:brick_breaker/features/authentication/views/login_view.dart';
import 'package:brick_breaker/utils/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:brick_breaker/utils/widgets/custom_input_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets/custom_text.dart';

class SignupView extends StatelessWidget {
  SignupView({
    super.key,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Color(0xff303B52),
      body: ModalProgressHUD(
        color: Color(0xff303B49),
        inAsyncCall: authViewModel.busy,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Account.',
                  style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.09,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset('assets/images/ellipse2.png'),
                    Image.asset('assets/images/Group.png')
                  ],
                ),
                SizedBox(
                  height: height * 0.09,
                ),
                CustomTextFormField(
                  textEditingController: _usernameController,
                  hintText: 'Username',
                  icon: Icon(Icons.person),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  textEditingController: _passwordController,
                  hintText: 'Enter Password',
                  obscuretext: true,
                  icon: Icon(Icons.key_outlined),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  textEditingController: _emailController,
                  hintText: 'Enter Email',
                  icon: Icon(Icons.mail),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                CustomButton(
                  onPress: () {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty) {
                      authViewModel.signUp(
                          email: _emailController.text,
                          password: _passwordController.text,
                          onCallBack: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()));
                          });
                    }
                  },
                  buttonchild: 'Sign up',
                  width: width * 0.35,
                  height: height * 0.08,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'Already have an account?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
                CustomText(
                  onpressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
                  },
                  text: 'Go back',
                  color: Color(0xff18A4DD),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
