

import 'package:aspen_travelle/app_config/common_classes/app_textfield.dart';
import 'package:aspen_travelle/onboarding/presention/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_config/common_classes/app_text.dart';
import '../../app_utils/app_colors.dart';
import '../../app_utils/app_string.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../dashboard/view_modle/dashboard_view_modle.dart';

class Register extends ConsumerStatefulWidget{
  const Register({super.key});

  @override
 ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  bool loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Future<void> saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(name!=null && email!=null && password!=null){
      Map<String,dynamic> userData = {
        "name":name,
        "email":email,
        "password":password
      };
     var res=await emailCheck(email);
     if(res==false){
       FirebaseFirestore.instance.collection("users").add(userData).whenComplete((){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));

       });
     }else{
       print("User Create");
     }


    }else{
      print("Fill Details");
    }

  }
  static Future<bool> emailCheck(String email) async {
    bool result = false;
    QuerySnapshot snapshot = await
    FirebaseFirestore.instance.collection('users').get();
    snapshot.docs.forEach((f) {
      if (f['email'] ==email) {
        result =true;
      }
    });
    return result;
  }


  // void createAccount (BuildContext context)async{
  //   String email =  emailController.text.trim();
  //   String password =  passwordController.text.trim();
  //   String cPassword =  cPasswordController.text.trim();
  //   if(email=="" || password==""||cPassword==""){
  //
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text("Please fill all Details"),
  //   ));
  //   }else if(password!= cPassword){
  //
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Password does not matche"),
  //     ));
  //   }else{
  //     try{//create new account
  //       setState(() {
  //         loading = true;
  //       });
  //       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  //       if(userCredential.user !=null){
  //
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  //       }
  //    
  //     }on FirebaseAuthException catch(ex){
  //      print(ex.code.toString() );
  //      if (ex.code == 'email-already-in-use') {
  //        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //          content: Text("email-already-in-use"),
  //        ));
  //
  //      }
  //
  //     }
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final registerBoardState = ref.watch(dashboardStateProvider);
    return Scaffold(

      body: SingleChildScrollView(
          
            
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
                          AppStrings.createAccountText,
                          color: AppColors.blueColor,
                          weight: FontWeight.w700,
                          fontSize: 30,
                        ),
                        const SizedBox(height: 20),
                        AppText(
                          AppStrings.createAccountSoThatText,
                          color: AppColors.blackColor,
                          weight: FontWeight.w500,
                          fontSize: 14,
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
                                child: AppTextField("Email",EmailValidator(errorText: "Invalid email"),controller: emailController,),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Stack(
                                children: [SizedBox(
                                  width: double.infinity,
                                  height: 64,
                                  child: AppTextField("Password",MinLengthValidator(errorText: "enter valid length",6),controller:passwordController,),

                                ),
                         Positioned(left: 130,
                              child: registerBoardState.loading1==true?
                              const CircularProgressIndicator(
                                backgroundColor: AppColors.blueColor,
                                valueColor: AlwaysStoppedAnimation(AppColors.whiteColor),
                                strokeWidth: 10,
                              ):Container(),
                            )
                                ]
                              ),
                            const SizedBox(height: 15,),

                              SizedBox(
                                width: double.infinity,
                                height: 64,
                                child: AppTextField("Confirm password",MinLengthValidator(errorText: "enter valid length",6),controller:nameController,),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()){
                                        print("Valid");
                                        // ref.read(dashboardStateProvider.notifier).createAccount(context);
                                        saveUser();
                                     passwordController.clear();
                                      emailController.clear();
                                       nameController.clear();
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
                                height: 30,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: AppText(
                                  AppStrings.alreadyHaveAccountText,
                                  fontSize: 14,
                                  weight: FontWeight.w600,
                                  color: AppColors.lightBlackColor,
                                ),
                              ),

                            ],
                          ),
                        ),
                      const SizedBox(height: 30,),
                        AppText(
                          AppStrings.orContinueWithText,
                          color: AppColors.blueColor,
                          weight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(onTap: (){
                              ref.read(dashboardStateProvider.notifier).signInWithGoogle();
                            },
                                child: SvgPicture.asset("assets/svg/google.svg")),
                            SvgPicture.asset("assets/svg/facebook.svg"),
                            SvgPicture.asset("assets/svg/apple.svg"),
                          ],
                        ),
                       const SizedBox(height: 30,)
                      ],
                    ),
                  ),
                )
           

          ),
    );
  }
}
