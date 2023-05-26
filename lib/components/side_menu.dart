import 'package:flutter/material.dart';
import 'package:todo_app_sync/components/custom_colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>{
  @override
  Widget build(BuildContext context){
    //screen size
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screen.width*0.7,
        height: double.infinity,
        color: CustomColors.primaryColor,
        child: SafeArea(
          child: Column(
            children:  const [
              SizedBox(height: 60,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Divider(
                  color: Colors.white70,
                  height: 1,
                ),
              ),

              //tile1

            ],
          ),
        ),
      ),
    );
  }
}