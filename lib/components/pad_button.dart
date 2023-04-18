import 'package:flutter/material.dart';
import 'custom_colors.dart';

class PadButton extends StatelessWidget{
  final int nbrtask;
  final String category;

  const PadButton({
    super.key,
    required this.nbrtask,
    required this.category
  });

  @override
  Widget build(BuildContext context) {
    return
      //bouton
      Container(
        padding: const EdgeInsets.only(right: 15.0),
        child: SizedBox(
          height: 90,
          child: Material(
            elevation: 7,
            borderRadius: BorderRadius.circular(20),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(CustomColors.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$nbrtask tâches",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}