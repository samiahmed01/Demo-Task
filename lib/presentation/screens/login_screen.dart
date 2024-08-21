import 'package:demotask/config/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/bloc/cubit/login_cubit.dart';
import '../../domain/bloc/state/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          else if (state.status == LoginStatus.error){
            var snackBar = SnackBar(content: Text('${state.errorMessage}'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state.status == LoginStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Log in!",style: TextStyle(fontSize: 41,fontWeight: FontWeight.w600,color: AppColors.pinkColor),),
                        const SizedBox(
                          height: 80.0,
                        ),
                        emailTextFieldWidget(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        passwordTextFieldWidget(),
                        const SizedBox(height: 40),
                        loginButtonWidget(),
                        const SizedBox(height: 10),
                        signUpButtonWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget emailTextFieldWidget(){
    return  TextFormField(
      style: const TextStyle(fontFamily: 'popins',fontSize: 14,color: AppColors.whiteColor),
      cursorColor: AppColors.whiteColor,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: SvgPicture.asset('assets/icons/email_ic.svg',fit: BoxFit.scaleDown,),
        labelText: 'Email',
        labelStyle: const TextStyle(fontFamily: 'popins',fontSize: 14,color: AppColors.whiteColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorStyle: const TextStyle(
            color: AppColors.redColor,
            fontSize: 11
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

      ),
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        }
        else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
          return 'Please enter valid email';
        }
        return null;
      },
    );
  }

  Widget passwordTextFieldWidget(){
    return TextFormField(
      obscureText: _obscureText,
      controller: _passwordController,// Hides the text being typed
      style: const TextStyle(fontFamily: 'popins',fontSize: 14,color: AppColors.whiteColor),
      cursorColor: AppColors.whiteColor,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: SvgPicture.asset('assets/icons/password_ic.svg',fit: BoxFit.scaleDown,),
        labelText: 'Password',
        suffixIcon: IconButton(
          color: AppColors.whiteColor,
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        labelStyle: const TextStyle(fontFamily: 'popins',fontSize: 14,color: AppColors.whiteColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorStyle: const TextStyle(
            color: AppColors.redColor,
            fontSize: 11
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget loginButtonWidget(){
    return Center(
      child: InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            context.read<LoginCubit>().signInWithEmailAndPassword(
              _emailController.text,
              _passwordController.text,
            );
          }
        },
        child: Container(
            height: 40.0,
            width: 150,
            decoration: const BoxDecoration(color: AppColors.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(95))),
            child: const Center(child: Text('Login',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: AppColors.blackColor),))),
      ),
    );
  }

  Widget signUpButtonWidget(){
    return Center(
      child: InkWell(
        onTap: () {
          context.read<LoginCubit>().signUpWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
        },
        child: Container(
            height: 40.0,
            width: 150,
            decoration: const BoxDecoration(color: AppColors.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(95))),
            child: const Center(child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: AppColors.blackColor),))),
      ),
    );
  }
}
