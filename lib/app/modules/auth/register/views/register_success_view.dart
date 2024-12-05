import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/auth/login/views/login_view.dart';
import 'package:maritimmuda_connect/themes.dart';

class RegisterSuccessView extends StatelessWidget {
  const RegisterSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: neutral02Color,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: neutral01Color,
                    border: Border.all(color: neutral03Color, width: 1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Image.asset("assets/images/maritimmuda_connect.png"),
                  ),
                ),
                const SizedBox(height: 55),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: neutral03Color, width: 1),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Please Verify Your Email Address",
                          textAlign: TextAlign.center,
                          style:
                              boldText20.copyWith(color: primaryDarkBlueColor),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.center,
                        "Kindly review your email inbox for a verification link before proceeding.",
                        style: regulerText14,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: (){
                          Get.to(() => const LoginView());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryBlueColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Back to Login",
                              style: boldText16.copyWith(color: neutral01Color),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
