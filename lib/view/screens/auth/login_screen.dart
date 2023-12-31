import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_snap/view/screens/auth/signup_screen.dart';
import 'package:real_snap/view/widgets/cusotm_button.dart';
import '../../../controller/auth_controller.dart';
import '../../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthController instance = AuthController.instance;

  var height = Get.height;
  var width = Get.width;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.2,),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * .07,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                      controller: _emailController,
                      myIcon: Icons.email,
                      myLableText: 'Email')),
              SizedBox(
                height: height * .02,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                      controller: _passwordController,
                      myIcon: Icons.password_rounded,
                      myLableText: 'Password')),
                      SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Don't have an account? "),
                
             GestureDetector
             (
              onTap: () {
                Get.offAll(const SignupScreen());
              },
              child: const Text('Create an account!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),))
              ],),
              SizedBox(
                height: height * .07,
              ),
              SizedBox(
                height: height * 0.07,
                width: width * 0.5,
                child: CustomButton(title: 'Login', onTap: ()=> instance.signIn(
                          _emailController.text, _passwordController.text))
              )
            ],
          ),
        ),
      ),
    );
  }
}
