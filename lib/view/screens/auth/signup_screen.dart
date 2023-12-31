import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_snap/view/screens/auth/login_screen.dart';
import 'package:real_snap/view/widgets/cusotm_button.dart';
import '../../../controller/auth_controller.dart';
import '../../widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _userName = TextEditingController();

 AuthController instance = AuthController.instance;
  var height = Get.height;
  var width = Get.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome To TikTok',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * .07,
              ),
               Column(
                children: [
                  // AuthController.instance.profileImage == null ?
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                  ) ,
                  // : Image(image: AuthController().profileImage.toString()),
                  GestureDetector(
onTap: () => instance.pickImage(),
                    child: const Text('Select Picture'))
                ],
              ),
              SizedBox(
                height: height * .03,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                      controller: _userName,
                      myIcon: Icons.person,
                      myLableText: 'UserName')),
              SizedBox(
                height: height * .03,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                      controller: _emailController,
                      myIcon: Icons.email,
                      myLableText: 'Email')),
              SizedBox(
                height: height * .03,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                      controller: _passwordController,
                      myIcon: Icons.password_rounded,
                      toHide: true,
                      myLableText: 'Set Password')),
              SizedBox(
                height: height * .03,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                      controller: _confirmpasswordController,
                      myIcon: Icons.password_rounded,
                      toHide: true,
                      myLableText: 'Confirm Password')),
                      SizedBox(
                height: height * .02,
              ),
                       Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Already have an account? "),
                
             GestureDetector
             (
              onTap: () {
                Get.offAll(const LoginScreen());
              },
              child: const Text('Sign in!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),))
              ],),
              SizedBox(
                height: height * .07,
              ),
              SizedBox(
                height: height * 0.07,
                width: width * 0.5,
                child: CustomButton(title: 'Create Account', onTap: ()=> instance.createAccount(_userName.text, _emailController.text, _passwordController.text, instance.profileImage))
              )
            ],
          ),
        ),
      ),
    );
  }
}
