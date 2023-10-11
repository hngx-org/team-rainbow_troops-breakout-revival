import 'package:brick_breaker/utils/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:brick_breaker/utils/widgets/custom_input_field.dart';

import '../../../utils/widgets/custom_text.dart';

class LoginView extends StatelessWidget {
  LoginView({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff303B52),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
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
                textEditingController: usernameController,
                hintText: 'Username or email',
                icon: Icon(Icons.person),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextFormField(
                textEditingController: passwordController,
                hintText: 'Enter Password',
                icon: Icon(Icons.key_outlined),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomButton(
                onPress: () {},
                buttonchild: 'Login',
                width: width * 0.35,
                height: height * 0.08,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomText(
                onpressed: () {},
                text: 'Forgot your username or password?',
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
