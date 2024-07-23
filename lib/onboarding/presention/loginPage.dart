

import 'package:aspen_travelle/app_config/common_classes/app_textfield.dart';
import 'package:aspen_travelle/dashboard/presention/home/presention/homepage.dart';

import 'package:aspen_travelle/onboarding/presention/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';


import '../../app_config/common_classes/app_text.dart';
import '../../app_utils/app_colors.dart';
import '../../app_utils/app_string.dart';
import '../../dashboard/view_modle/dashboard_view_modle.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  loginUser() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    var result=await emailCheck(email);
    if(result==password){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }else{
      print('Wrong credentials');
    }
  }
  static Future<String> emailCheck(String email) async {
    String password = "";
    QuerySnapshot snapshot = await
    FirebaseFirestore.instance.collection('users').get();
    snapshot.docs.forEach((f) {
      if (f['email'] ==email) {
        password =f['password'];
      }
    });
    return password;
  }

  // void login(BuildContext context)async{
  //
  //
  //   String email =  emailController.text.trim();
  //   String password =  passwordController.text.trim();
  //   if(email=="" || password==""){
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Please fill Details                                                                           "),
  //     ));
  //     print("Please fill Details");
  //   }else{
  //
  //     try {
  //       setState(() {
  //         loading = true;
  //       });
  //
  //       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //           email: email,
  //           password: password
  //       );
  //       if(userCredential.user !=null){
  //
  //
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoard()));
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'user-not-found') {
  //         print('No user found for that email.');
  //       } else if (e.code == 'wrong-password') {
  //         print('Wrong password provided for that user.');
  //
  //       } ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("Wrong Details provided for that user"),
  //       ));
  //     }}
  // }
  @override
  Widget build(BuildContext context) {
    final loginBoardState = ref.watch(dashboardStateProvider);


    return Scaffold(

      body: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      AppText(
                        AppStrings.loginHereText,
                        color: AppColors.blueColor,
                        weight: FontWeight.w600,
                        fontSize: 30,
                      ),
                      const SizedBox(height: 20),
                      AppText(
                        AppStrings.welcomeBackText,
                        color: AppColors.blackColor,
                        weight: FontWeight.w600,
                        fontSize: 20,
                        textAlign: TextAlign.center,
                      ),
                  
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                  
                        width: 357,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 64,
                              child: AppTextField("Email",EmailValidator(errorText: "Invalid Email"),controller: loginBoardState.emailController,),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children:[ SizedBox(
                                width: double.infinity,
                                height: 64,
                                child: AppTextField("Password",MinLengthValidator(6,errorText: "enter a valid length"),controller: loginBoardState.passwordController,),
                              ),

                                Positioned(left: 130,
                                  child: loginBoardState.loading == true?
                                  const CircularProgressIndicator(
                                    backgroundColor: AppColors.blueColor,
                                    valueColor: AlwaysStoppedAnimation(AppColors.whiteColor),
                                    strokeWidth: 10,
                                  ):Container(),
                                )
                              ]
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: AppText(
                                AppStrings.forgotYourPassword,
                                color: AppColors.blueColor,
                                weight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()){
                                    // loginUser();
                                      ref.read(dashboardStateProvider.notifier).login(context);
                                      loginBoardState.emailController.clear();
                                      loginBoardState.passwordController.clear();

                                      // login(context);
                                      print("Valid");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blueColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: AppText(
                                    AppStrings.signInText,
                                    color: AppColors.whiteColor,
                                    weight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                )),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
                              },
                              child: AppText(
                                AppStrings.createNewAccountText,
                                fontSize: 14,
                                weight: FontWeight.w600,
                                color: AppColors.lightBlackColor,
                              ),
                            ),
                  
                          ],
                        ),
                      ),
                      const Spacer(),
                      AppText(
                        AppStrings.orContinueWithText,
                        color: AppColors.blueColor,
                        weight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap:  (){
                               ref.read(dashboardStateProvider.notifier).signInWithGoogle().then((googlekey){
                              print(googlekey.additionalUserInfo.profile["email"]);
                              });



                            },
                              child: SvgPicture.asset("assets/svg/google.svg")),
                          InkWell(
                            onTap:
                            (){
                              ref.read(dashboardStateProvider.notifier).signOutFromGoogle();
                            },
                              child: SvgPicture.asset("assets/svg/facebook.svg")),
                          SvgPicture.asset("assets/svg/apple.svg"),
                        ],
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              )
            ),

      ]),
    );
  }
}
