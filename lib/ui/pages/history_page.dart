import 'package:estok_app/ui/pages/profile_page.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 1;

    return Scaffold(
      appBar: CustomAppBar(titleText: "HISTORICO",returnArrow: false,),
      body: Center(child: Text("Histórico")),
    );
  }
}
