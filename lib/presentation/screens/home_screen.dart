import 'package:demotask/config/color/color.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the home screen!',style: TextStyle(color: AppColors.whiteColor)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
