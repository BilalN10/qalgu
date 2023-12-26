import 'package:flutter/material.dart';
import 'package:qalgu/constants/colors.dart';

class AnimatedSwitch extends StatefulWidget {
  const AnimatedSwitch({super.key});

  @override
  State<AnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  var isEnabled = false;
  final animationDuration = const Duration(milliseconds: 400);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnabled = !isEnabled;
        });
      },
      child: AnimatedContainer(
        duration: animationDuration,
        height: 25,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isEnabled ? ColorsClass.primaryColor : Colors.white,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: AnimatedAlign(
            duration: animationDuration,
            alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isEnabled
                      ? Colors.white
                      : ColorsClass.primaryColor.withOpacity(.4),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
