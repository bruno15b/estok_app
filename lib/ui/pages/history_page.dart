import 'package:estok_app/ui/pages/profile_page.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 1;

    return Scaffold(
      appBar: CustomAppBar("HISTORICO"),
      body: Center(child: Text("Histórico")),
      bottomNavigationBar: BottomNavigationBar(
      elevation: 0,
      backgroundColor: Color(0xFFF6F5F5),

      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 20,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.playlist_add_check,
            size: 20,
          ),
          label: 'Histórico',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            size: 20,
          ),
          label: 'Perfil',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (int index){
        switch (index) {
          case 0:
            Navigator.of(context).pop();
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ProfilePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            break;
        }
      },
    ),
    );
  }
}
