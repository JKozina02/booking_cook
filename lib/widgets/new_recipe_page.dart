import 'package:flutter/material.dart';

class NewRecipePage extends StatelessWidget {
  const NewRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(
      child: Column(children: [
        
        ElevatedButton(onPressed: null, child: Text("SAVE"))
      ]),
      )
    );
  }
}
