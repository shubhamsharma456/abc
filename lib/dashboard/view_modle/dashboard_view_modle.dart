import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../onboarding/presention/loginPage.dart';
import '../presention/dashboard_Page.dart';

class Popular{
  String? image;
  String? place;
  double? rating;

  Popular(this.image, this.place, this.rating);
}

class DashBoardState{
  List<String>? activities;
  int selectedIndex;
  int dashboardSelectedIndex;
  List<Popular>? popular;
  TextEditingController emailController ;
  TextEditingController passwordController;
  TextEditingController cPasswordController ;
  bool ?loading = false;
  bool ?loading1 = false;

//<editor-fold desc="Data Methods">
  DashBoardState({
    this.activities,
    required this.selectedIndex,
    required this.dashboardSelectedIndex,
    this.popular,
    required this.emailController,
    required this.passwordController,
    required this.cPasswordController,
    this.loading,
    this.loading1,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DashBoardState &&
          runtimeType == other.runtimeType &&
          activities == other.activities &&
          selectedIndex == other.selectedIndex &&
          dashboardSelectedIndex == other.dashboardSelectedIndex &&
          popular == other.popular &&
          emailController == other.emailController &&
          passwordController == other.passwordController &&
          cPasswordController == other.cPasswordController &&
          loading == other.loading &&
          loading1 == other.loading1);

  @override
  int get hashCode =>
      activities.hashCode ^
      selectedIndex.hashCode ^
      dashboardSelectedIndex.hashCode ^
      popular.hashCode ^
      emailController.hashCode ^
      passwordController.hashCode ^
      cPasswordController.hashCode ^
      loading.hashCode ^
      loading1.hashCode;

  @override
  String toString() {
    return 'DashBoardState{' +
        ' activities: $activities,' +
        ' selectedIndex: $selectedIndex,' +
        ' dashboardSelectedIndex: $dashboardSelectedIndex,' +
        ' popular: $popular,' +
        ' emailController: $emailController,' +
        ' passwordController: $passwordController,' +
        ' cPasswordController: $cPasswordController,' +
        ' loading: $loading,' +
        ' loading1: $loading1,' +
        '}';
  }

  DashBoardState copyWith({
    List<String>? activities,
    int? selectedIndex,
    int? dashboardSelectedIndex,
    List<Popular>? popular,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? cPasswordController,
    bool? loading,
    bool? loading1,
  }) {
    return DashBoardState(
      activities: activities ?? this.activities,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      dashboardSelectedIndex:
          dashboardSelectedIndex ?? this.dashboardSelectedIndex,
      popular: popular ?? this.popular,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      cPasswordController: cPasswordController ?? this.cPasswordController,
      loading: loading ?? this.loading,
      loading1: loading1 ?? this.loading1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activities': this.activities,
      'selectedIndex': this.selectedIndex,
      'dashboardSelectedIndex': this.dashboardSelectedIndex,
      'popular': this.popular,
      'emailController': this.emailController,
      'passwordController': this.passwordController,
      'cPasswordController': this.cPasswordController,
      'loading': this.loading,
      'loading1': this.loading1,
    };
  }

  factory DashBoardState.fromMap(Map<String, dynamic> map) {
    return DashBoardState(
      activities: map['activities'] as List<String>,
      selectedIndex: map['selectedIndex'] as int,
      dashboardSelectedIndex: map['dashboardSelectedIndex'] as int,
      popular: map['popular'] as List<Popular>,
      emailController: map['emailController'] as TextEditingController,
      passwordController: map['passwordController'] as TextEditingController,
      cPasswordController: map['cPasswordController'] as TextEditingController,
      loading: map['loading'] as bool,
      loading1: map['loading1'] as bool,
    );
  }

//</editor-fold>
}

final dashboardStateProvider = StateNotifierProvider<DashBoardController,DashBoardState>((ref) => DashBoardController());


class  DashBoardController extends  StateNotifier<DashBoardState> {
   DashBoardController():super(DashBoardState(selectedIndex: 0,dashboardSelectedIndex: 0, emailController: TextEditingController(), passwordController: TextEditingController(), cPasswordController: TextEditingController(), ),);


  getIndex(i){
    state =state.copyWith(selectedIndex: i);
  }
setIndex(i){
  state =state.copyWith(dashboardSelectedIndex: i);
}

   initializeData(){
     state.activities =<String>[];
     state.popular =<Popular>[];
     state.activities?.add("Location");
     state.activities?.add("Hotels");
     state.activities?.add("Food");
     state.activities?.add("Adventure");
     state.popular?.add(Popular("assets/images/alleypalace.png", "Alley Palace", 4.3));
     state.popular?.add(Popular("assets/images/coeurdesalpes.png", "Coeurdes Alpes", 4.3));
     state.popular?.add(Popular("assets/images/alleypalace.png", "Alley Palace", 4.3));
     state.popular?.add(Popular("assets/images/coeurdesalpes.png", "Coeurdes Alpes", 4.3));

   }
   void login(BuildContext context)async{


     String email =  state.emailController.text.trim();
     String password = state.passwordController.text.trim();
     if(email=="" || password==""){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text("Please fill Details                                                                           "),
       ));
       print("Please fill Details");
     }else{

       try {

         state=   state.copyWith(loading: true);


         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
             email: email,
             password: password
         );
         if(userCredential.user !=null){


           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoard()));
         }
       } on FirebaseAuthException catch (e) {
         if (e.code == 'user-not-found') {
           print('No user found for that email.');
         } else if (e.code == 'wrong-password') {
           print('Wrong password provided for that user.');

         } ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
           content: Text("Wrong Details provided for that user"),
         ));
       }}
   }

   void createAccount (BuildContext context)async{
     String email =  state.emailController.text.trim();
     String password =  state.passwordController.text.trim();
     String cPassword = state.cPasswordController.text.trim();
     if(email=="" || password==""||cPassword==""){

       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text("Please fill all Details"),
       ));
     }else if(password!= cPassword){

       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text("Password does not matche"),
       ));
     }else{
       try{//create new account
         state=   state.copyWith(loading1: true);
         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
         if(userCredential.user !=null){

           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
         }

       }on FirebaseAuthException catch(ex){
         print(ex.code.toString() );
         if (ex.code == 'email-already-in-use') {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
             content: Text("email-already-in-use"),
           ));

         }

       }

     }

   }


   Future<dynamic> signInWithGoogle() async {

     try {

       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

       final GoogleSignInAuthentication? googleAuth =
       await googleUser?.authentication;

       final credential = GoogleAuthProvider.credential(
         accessToken: googleAuth?.accessToken,
         idToken: googleAuth?.idToken,

       );

       if (FirebaseAuth.instance.currentUser !=null)


         return await FirebaseAuth.instance.signInWithCredential(credential);

     } on Exception catch (e) {
       // TODO
       print('exception->$e');
     }
   }
   Future<bool> signOutFromGoogle() async {
     try {
       await FirebaseAuth.instance.signOut();
       return true;
     } on Exception catch (_) {
       return false;
     }
   }


}
