import 'package:color_randomizer_test_app/screens/archive_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_providers/color_generator.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorGenerator state = Provider.of<ColorGenerator>(context);
    return Scaffold(
      body: InkWell(
        onTap: () => state.setRandomColor(),
        child: SizedBox(
          width: double.infinity,
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            color: state.getColor(),
            child: Center(
              child: Material(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                elevation: 20,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Hey there",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 56,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "AUTOMATICALLY",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CupertinoSwitch(
                      trackColor: Colors.black,
                      value: state.isEnabled(),
                      onChanged: (bool value) {
                        state.changeToogle(value);
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                width: 54,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.black)))),
                  onPressed: () => {
                    state.stopAutomaticallyColorChanging(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RGBListScreen(),
                      ),
                    )
                  },
                  child: const Text(
                    'ARCHIVE',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
