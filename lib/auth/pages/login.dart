import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/auth/pages/otp_page.dart';
import 'package:task_manager/common/utils/constant.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_ont_btn.dart';
import 'package:task_manager/common/widgets/custom_text.dart';
import 'package:task_manager/common/widgets/hieght_spacer.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "INDIA",
      example: "INDIA",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              const HieghtSpacer(
                hieght: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "LOGIN",
                  textAlign: TextAlign.center,
                  style: appstyle(36, AppConst.kLight, FontWeight.w500),
                ),
              ),
              const HieghtSpacer(hieght: 150),
              const Icon(
                Icons.home_work_outlined,
                size: 180,
                color: AppConst.kLight,
              ),
              const HieghtSpacer(
                hieght: 100,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: ReusableText(
                    text: "Please enter your phone number",
                    style: appstyle(17, AppConst.kLight, FontWeight.w500)),
              ),
              const HieghtSpacer(hieght: 20),
              Center(
                child: CustomTextField(
                  controller: phone,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                                backgroundColor: AppConst.kLight,
                                bottomSheetHeight: AppConst.kHieght * 0.6,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppConst.kRadius),
                                  topRight: Radius.circular(AppConst.kRadius),
                                )),
                            onSelect: (code) {
                              setState(() {});
                            });
                      },
                      child: ReusableText(
                          text: "${country.flagEmoji} +${country.phoneCode} ",
                          style:
                              appstyle(18, AppConst.kBkDark, FontWeight.w600)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  hintText: "Enter phone number",
                  hintStyle: appstyle(16, AppConst.kBkDark, FontWeight.w600),
                ),
              ),
              const HieghtSpacer(hieght: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOtlnBtn(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OtpPage()));
                    },
                    width: AppConst.kWidth * 0.9,
                    height: AppConst.kHieght * 0.075,
                    color: AppConst.kBkDark,
                    color2: AppConst.kLight,
                    text: "Send Code"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
