import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/pages/history_page.dart';
import 'package:estok_app/ui/pages/home_page.dart';
import 'package:estok_app/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPage extends StatelessWidget {

  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, snapshot,userModel) {
        return Scaffold(
          body: _pages[userModel.currentIndexPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: userModel.currentIndexPage,
            selectedLabelStyle: TextStyle(fontSize: 12),
            unselectedLabelStyle: TextStyle(fontSize: 12),
            elevation: 0,
            backgroundColor: Color(0xFFF6F5F5),
            onTap: (index) {
              userModel.changePage(index);
            },
            items:[
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
          ),
        );
      }
    );
  }
}
