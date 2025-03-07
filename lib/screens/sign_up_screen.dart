import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignUpScreen());

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  Uint8List? _profileImage;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _bio.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(flex: 2, child: Container()),

              SvgPicture.asset(
                'assets/ic_instagram.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                height: 64,
              ),

              SizedBox(height: 48),

              Stack(
                children: [
                  _profileImage != null
                      ? CircleAvatar(
                        radius: 80,
                        backgroundImage: MemoryImage(_profileImage!),
                      )
                      : const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1741091475787-8cf779895451?q=80&w=3869&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                      ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(Icons.add_a_photo),
                      color: blueColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              TextFieldInput(
                controller: _email,
                hintText: "Enter Your Email",
                textInputType: TextInputType.emailAddress,
              ),

              SizedBox(height: 16),

              TextFieldInput(
                controller: _password,
                hintText: "Enter Your Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),

              SizedBox(height: 16),

              TextFieldInput(
                controller: _username,
                hintText: "Enter Your Username",
                textInputType: TextInputType.text,
              ),

              SizedBox(height: 16),

              TextFieldInput(
                controller: _bio,
                hintText: "Enter Your Bio",
                textInputType: TextInputType.text,
              ),

              SizedBox(height: 24),

              InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUp(
                    email: _email.text,
                    password: _password.text,
                    username: _username.text,
                    bio: _bio.text,
                  );
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: Text('Log In'),
                ),
              ),

              Flexible(flex: 2, child: Container()),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
