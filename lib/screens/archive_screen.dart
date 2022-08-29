import 'package:color_randomizer_test_app/data_providers/color_generator.dart';
import 'package:color_randomizer_test_app/models/model_rgb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RGBListScreen extends StatelessWidget {
  const RGBListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorGenerator state = Provider.of<ColorGenerator>(context);
    return Scaffold(
      body: FutureBuilder<List<ModelRGB>>(
        future: state.getColors(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    height: 58,
                    color: Color(snapshot.data![index].colorNumber),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                          "32 bit value : ${snapshot.data![index].colorNumber}"),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => {
          Navigator.pop(context),
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}
