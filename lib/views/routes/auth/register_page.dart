import 'package:flowop/global/constant/color.dart';
import 'package:flowop/global/constant/icons.dart';
import 'package:flowop/logic/bloc/auth/auth_bloc.dart';
import 'package:flowop/logic/bloc/auth/auth_event.dart';
import 'package:flowop/logic/bloc/auth/auth_state.dart';
import 'package:flowop/logic/repositories/user_repository.dart';
import 'package:flowop/utils/snack_bar.dart';
import 'package:flowop/views/routes/auth/login_page.dart';
import 'package:flowop/views/routes/home/patient_manage.dart';
import 'package:flowop/views/widgets/alert_dialog/alert_dialog_builder.dart';
import 'package:flowop/views/widgets/app_bar.dart';
import 'package:flowop/views/widgets/app_button.dart';
import 'package:flowop/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowop/utils/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
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
        Get.to(() => const PatientsManager());
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
      if (state is LoggeddUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PatientsManager()),
        );
      }
    });
  }

  Widget buildUI() {
    return Scaffold(
      appBar: BaseAppBar.lightAppBar(context: context, titleString: "Register"),
      body: _registerForm(),
    ).unfocus();
  }

  Widget _registerForm() {
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
            context.read<AuthBloc>().add(Register(
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
                'Register With'.liteGrey().b().marg(0, 0, 30, 15),
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
        'Already have an account?'
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
      ],
    ).marg(0, 16));
  }
}
