import 'package:flowop/global/constant/color.dart';
import 'package:flowop/global/constant/icons.dart';
import 'package:flowop/logic/bloc/auth/auth_bloc.dart';
import 'package:flowop/logic/bloc/auth/auth_event.dart';
import 'package:flowop/logic/bloc/auth/auth_state.dart';
import 'package:flowop/logic/repositories/user_repository.dart';
import 'package:flowop/utils/snack_bar.dart';
import 'package:flowop/views/routes/auth/register_page.dart';
import 'package:flowop/views/routes/home/patient_manage.dart';
import 'package:flowop/views/widgets/alert_dialog/alert_dialog_builder.dart';
import 'package:flowop/views/widgets/app_bar.dart';
import 'package:flowop/views/widgets/app_button.dart';
import 'package:flowop/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flowop/utils/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: BaseAppBar.lightAppBar(context: context, titleString: "Sign In"),
    // );
    return BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
      return buildUI();
    }, listener: (context, state) {
      if (state is LoggeddUser) {
        ScaffoldMessenger.of(context).showSnackBar(
            ExpandedSnackBar.successSnackBar(
                context, "Welcome back " + UserRepository.email!));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PatientsManager()),
        );
      }
      if (state is VerifyFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            ExpandedSnackBar.failureSnackBar(context, state.errorString));
      }
      if (state is AuthLoading) {
        showLoadingDialog();
      } else {
        closeLoading();
      }
    });
  }

  Widget buildUI() {
    return Scaffold(
      appBar: BaseAppBar.lightAppBar(context: context, titleString: "Sign In"),
      body: _signInForm(),
    ).unfocus();
  }

  Widget _signInForm() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Email'.desc().marg(0, 0, 20),
        AppTextInputField.authVisibleInputText(
          controller: _emailController,
        ).marg(0, 0, 6, 20),
        'Password'.desc(),
        AppTextInputField.authObscureInputText(
          controller: _passwordController,
        ).marg(0, 0, 6, 20),
        AppButton.primary(
          onTap: () {
            // Get.to(page)
            context.read<AuthBloc>().add(Login(
                email: _emailController.text,
                password: _passwordController.text));
          },
          child: 'Confirm'.buttonTitle(),
          borderRadius: BorderRadius.circular(2),
        ),
        Center(
          child: SizedBox(
            width: 160,
            child: Column(
              children: [
                'Sign In With'.liteGrey().b().marg(0, 0, 30, 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppIcons.instaLogo)
                        .square(40)
                        .rectAll(20)
                        .inkTap(onTap: () {
                      showUnderDevelopmentFunction(context);
                    }),
                    SvgPicture.asset(AppIcons.googleLogo)
                        .square(40)
                        .rectAll(20)
                        .inkTap(onTap: () {
                      showUnderDevelopmentFunction(context);
                    }),
                    Image.asset(AppIcons.facebookLogo)
                        .square(40)
                        .rectAll(20)
                        .inkTap(onTap: () {
                      showUnderDevelopmentFunction(context);
                    }),
                  ],
                ),
              ],
            ).marg(16, 0),
          ),
        ),
        'Do not have account?'
            .plain()
            .color(AppColors.textSecondary)
            .b()
            .inkTap(onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientsManager()),
              );
            })
            .center()
            .marg(
              0,
              0,
              28,
            ),
        'Forgot password?'
            .plain()
            .color(AppColors.textSecondary)
            .b()
            .inkTap(onTap: () {
              showUnderDevelopmentFunction(context);
            })
            .center()
            .marg(0, 0, 10)
      ],
    ).marg(0, 16));
  }
}
