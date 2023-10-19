import 'package:brick_breaker/utils/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:brick_breaker/utils/widgets/custom_input_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:brick_breaker/features/authentication/viewmodels/authentication_view_model.dart';
import 'package:provider/provider.dart';
import '../../../utils/widgets/custom_text.dart';

class LoginView extends StatelessWidget {
  LoginView({
    super.key,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AuthViewModel authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xff303B52),
      body: ModalProgressHUD(
        color: const Color(0xff303B49),
        inAsyncCall: authViewModel.busy,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.09,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset('assets/images/ellipse1.png'),
                    Image.asset('assets/images/Group.png')
                  ],
                ),
                SizedBox(
                  height: height * 0.09,
                ),
                CustomTextFormField(
                  textEditingController: _emailController,
                  hintText: 'Username or email',
                  icon: const Icon(Icons.person),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  textEditingController: _passwordController,
                  hintText: 'Enter Password',
                  obscuretext: true,
                  icon: const Icon(Icons.key_outlined),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                CustomButton(
                  onPress: () {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      authViewModel.logIn(
                          email: _emailController.text,
                          password: _passwordController.text);
                    }
                  },
                  buttonchild: 'Login',
                  width: width * 0.35,
                  height: height * 0.08,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                CustomText(
                  onpressed: () {
                    authViewModel.navigateToSignup();
                  },
                  text: 'Forgot your username or password?',
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
