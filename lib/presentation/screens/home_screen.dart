import 'package:demotask/config/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bloc/cubit/login_cubit.dart';
import '../../domain/bloc/state/login_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Home',style: TextStyle(color: AppColors.whiteColor),),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.initial) {
            Navigator.pushNamedAndRemoveUntil(context, '/login',(Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome to the home screen!',style: TextStyle(color: AppColors.whiteColor)),
                SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () {
                      context.read<LoginCubit>().signOut();
                    },
                    child: Container(
                        height: 40.0,
                        width: 150,
                        decoration: const BoxDecoration(color: AppColors.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(95))),
                        child: const Center(child: Text('Sign Out',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: AppColors.blackColor),))),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
