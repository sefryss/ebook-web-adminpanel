import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebookadminpanel/controller/data/key_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ebookadminpanel/main.dart';
import 'package:ebookadminpanel/theme/color_scheme.dart';
import 'package:ebookadminpanel/ui/common/common.dart';
import 'package:ebookadminpanel/util/app_routes.dart';
import 'package:ebookadminpanel/util/constants.dart';
import 'package:ebookadminpanel/util/responsive.dart';
import '../../controller/data/LoginData.dart';
import '../../theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  RxBool isProgress = false.obs;
  RxBool isSignUp = false.obs;

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);


    print("called------loginPage");
    return WillPopScope(
      child: Scaffold(
        backgroundColor: (Get.isDarkMode)?getCardColor(context):getBackgroundColor(context),
        body: SafeArea(
          child: Container(
            child: Row(
              children: [

                // Visibility(child: Expanded(child: Container(
                //
                //   color: "#FFEDE9".toColor(),
                //   height: double.infinity,
                //   width: double.infinity,
                //   child: Column(
                //     children: [
                //       Expanded(child: Container(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //            children: [
                //              getMaxLineFont(context, 'E-book', 150, getPrimaryColor(context),1,
                //                  customFont: Constants.headerFontsFamily,fontWeight:FontWeight.w900),
                //              getVerticalSpace(context, 15),
                //              getTextWidget(context, 'An e-reader, also called an e-book reader or e-book device, is a mobile electronic device that is designed primarily for the purpose of reading digital e-books and periodicals.'
                //                  , 45, textColor,
                //                  textAlign: TextAlign.center,fontWeight:FontWeight.w500),
                //            ],
                //         ).marginSymmetric(horizontal: 200.h),
                //       ),flex: 1,),
                //       Expanded(child: Container(
                //         margin: EdgeInsets.only(top: 150.h),
                //         alignment: Alignment.bottomCenter,
                //         child: Image.asset(Constants.assetPath+'frame.png', height: double.infinity, ),
                //       ),flex: 1,),
                //     ],
                //   ),
                //
                // )),visible: Responsive.isDesktop(context),),

                Visibility(visible: Responsive.isDesktop(context),child: Expanded(child: Container())),

                Expanded(
                  child: Obx(() => (isSignUp.value)?getSignUpView():getLoginView()),
                  // flex: Responsive.isDesktop(context) ||
                  //         Responsive.isTablet(context)
                  //     ? 1
                  //     : 2,
                ),
                
                Visibility(visible: Responsive.isDesktop(context),child: Expanded(child: Container()))


              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Constants.exitApp();
        return false;
      },
    );
  }


  getLoginView(){

    print("called------loginPage----111");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          color: (Get.isDarkMode)?getBackgroundColor(context):getCardColor(context),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  getResizeRadius(context, 25))),
          margin: EdgeInsets.symmetric(vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(context, 30),
              Align(
                alignment: Alignment.center,
                child: getTextWidget(context, 'Login', 100, getFontColor(context),
                    fontWeight: FontWeight.bold,
                    customFont: Constants.headerFontsFamily),
              ),

              getVerticalSpace(context, 30),
              getTextWidget(
                context,
                'Email',
                40,
                getFontColor(context),
                fontWeight: FontWeight.w500,
              ),
              getVerticalSpace(context, 15),
              getDefaultTextFiledWidget(
                  context, "Email", emailController),
              getVerticalSpace(context, 30),
              getTextWidget(
                context,
                'Password',
                40,
                getFontColor(context),
                fontWeight: FontWeight.w500,
              ),
              getVerticalSpace(context, 15),
              getPasswordTextFiledWidget(
                  context, "Password", passwordController,onSubmit: (value){
                isProgress.value = true;
                _login();

              }),
              getVerticalSpace(context, 30),
              Obx(() {
                return getButtonWidget(context, 'Log In', () {
                  isProgress.value = true;
                  _login();
                },
                    isProgress: isProgress.value,
                    horizontalSpace: 0,
                    bgColor: primaryColor,
                    textColor: Colors.white,
                    verticalSpace: 0);
              }),
              // getVerticalSpace(context, 15),
              //
              // StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore.instance.collection(KeyTable.adminData).snapshots(),
              //   builder: (context, snapshot) {
              //
              //     if(snapshot.data != null && snapshot.data!.size > 0){
              //
              //       print("sna-----------${snapshot.data}");
              //
              //       return Container();
              //
              //
              //
              //       // if(snapshot.connectionState == ConnectionState.active){
              //       //   return Container();
              //       // }else{
              //       //   return Container();
              //       // }
              //
              //     }else{
              //       if(snapshot.connectionState == ConnectionState.active){
              //         return Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               'Don\'t have an account?',
              //               textAlign: TextAlign.center,
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .labelMedium!
              //                   .copyWith(
              //                   color: Colors.grey.shade600,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //
              //             SizedBox(
              //               width: 5.h,
              //             ),
              //             InkWell(
              //               onTap: (){
              //                 isSignUp.value = true;
              //                 passwordController.text = "";
              //                 emailController.text = "";
              //                 confirmPasswordController.text = "";
              //               },
              //               child: Text(
              //                 'Sign Up',
              //                 textAlign: TextAlign.center,
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .labelMedium!
              //                     .copyWith(
              //                     color: primaryColor,
              //                     fontWeight: FontWeight.w600),
              //               ),
              //             ),
              //           ],
              //         );
              //       }else{
              //         return Container();
              //       }
              //     }
              //
              // },),
              getVerticalSpace(context, 30),
            ],
          ).paddingSymmetric(horizontal: 30.h),
        ),
      ],
    ).marginSymmetric(horizontal: Responsive.isDesktop(context)?0.h:15.h);
    // ).marginSymmetric(horizontal: Responsive.isDesktop(context)?200.h:15.h);
  }

  getSignUpView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Card(
          color: (Get.isDarkMode)?getBackgroundColor(context):getCardColor(context),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  getResizeRadius(context, 25))),
          margin: EdgeInsets.symmetric(vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(context, 30),
              Align(
                alignment: Alignment.center,
                child: getTextWidget(context, 'Admin', 70, getFontColor(context),
                    fontWeight: FontWeight.bold,
                    customFont: Constants.fontsFamily),
              ),
              getVerticalSpace(context, 30),
              getTextWidget(
                context,
                'Email',
                40,
                getFontColor(context),
                fontWeight: FontWeight.w500,
              ),
              getVerticalSpace(context, 15),
              getDefaultTextFiledWidget(
                  context, "Email", emailController),
              getVerticalSpace(context, 30),
              getTextWidget(
                context,
                'Password',
                40,
                getFontColor(context),
                fontWeight: FontWeight.w500,
              ),
              getVerticalSpace(context, 15),
              getPasswordTextFiledWidget(
                context, "Password", passwordController,onSubmit: (value){
                isProgress.value = true;
                // _login();

              },),

              getVerticalSpace(context, 30),
              getTextWidget(
                context,
                'Confirm Password',
                40,
                getFontColor(context),
                fontWeight: FontWeight.w500,
              ),
              getVerticalSpace(context, 15),
              getPasswordTextFiledWidget(
                context, "Confirm Password", confirmPasswordController,onSubmit: (value){
                isProgress.value = true;
                // _login();

              },),
              getVerticalSpace(context, 30),
              Obx(() {
                return getButtonWidget(context, 'Create', () {
                  isProgress.value = true;
                  signUp();
                },
                    isProgress: isProgress.value,
                    horizontalSpace: 0,
                    bgColor: primaryColor,
                    textColor: Colors.white,
                    verticalSpace: 0);
              }),
              getVerticalSpace(context, 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                  ),

                  SizedBox(
                    width: 5.h,
                  ),
                  InkWell(
                    onTap: (){
                      isSignUp.value = false;

                      passwordController.text = "";
                      emailController.text = "";
                      confirmPasswordController.text = "";
                    },
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              getVerticalSpace(context, 30),



            ],
          ).paddingSymmetric(horizontal: 30.h),
        ),
      ],
    ).marginSymmetric(horizontal: Responsive.isDesktop(context)?0.h:15.h);
    // ).marginSymmetric(horizontal: Responsive.isDesktop(context)?200.h:15.h);
  }
  getSideSpace() {
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Expanded(
            child: Container(),
            flex: 1,
          )
        : Container().marginSymmetric(horizontal: 15.h);
  }

  void _login() async {

    if(isNotEmpty(emailController.text)){


      if(isNotEmpty(passwordController.text)){

        bool isLoginComplete = await LoginData.login(
            context,
            password: passwordController.text, username: emailController.text);

        if (isLoginComplete) {
          isProgress.value = false;
          Constants.pushPage(KeyUtil.homePage, function: (value) {});
          passwordController.text = '';
          emailController.text = '';

        } else {
          isProgress.value = false;
          // showCustomToast(
          //     message: "Something wrong", context: context, title: 'Error');
        }


      }else{
        showCustomToast(context: context, message: "Please enter password");
        isProgress.value = false;
      }
    }else{
      showCustomToast(context: context, message: "Please enter email");
      isProgress.value = false;
    }

  }


  bool checkValidation(){
    if(isNotEmpty(emailController.text) && isValidEmail(emailController.text)){



        if(isNotEmpty(passwordController.text)){


          if(passwordController.text.length >= 6){

            if(passwordController.text == confirmPasswordController.text){

              return true;

            }else{
              showCustomToast(context: context, message: "Password dose not match");
              return false;
            }

          }else{
            showCustomToast(context: context, message: "You must have 6 characters in your password");
            return false;
          }

        }else{
          showCustomToast(context: context, message: "Enter Password");
          return false;
        }

    }else{
      showCustomToast(context: context, message: "Email not valid");
      return false;
    }
  }

  void signUp() async {


    if(checkValidation()){



       await LoginData.createAdmin(

          password: passwordController.text, username: emailController.text,context: context,function: (){

        isProgress.value = false;
        Constants.pushPage(KeyUtil.homePage, function: (value) {});
        passwordController.text = '';
        emailController.text = '';
      });


        isProgress.value = false;
        // showCustomToast(
        //     message: "Something wrong", context: context, title: 'Error');



    }

    isProgress.value = false;


    //
    // isProgress.value = false;
    //
    // if (isLoginComplete != null && isLoginComplete) {
    //
    //
    //   selectedAction.value = await PrefData.getAction();
    //
    //   Constants.pushPage(KeyUtil.homePage, function: (value) {});
    //   passwordController.text = '';
    //   emailController.text = '';
    // } else {
    //
    //   if(isLoginComplete !=null){
    //     showCustomToast(
    //         message: "Something wrong", context: context, title: 'Error');
    //   }
    // }

  }
}