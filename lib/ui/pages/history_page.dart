import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("HISTORICO"),
      body: Center(child: Text("Histórico")),
    );
  }
}
