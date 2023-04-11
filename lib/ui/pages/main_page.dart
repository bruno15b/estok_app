import 'package:estok_app/enums/progress_enum.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/pages/history_page.dart';
import 'package:estok_app/ui/pages/home_page.dart';
import 'package:estok_app/ui/pages/profile_page.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_navigation_drawer.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_page.dart';

class MainPage extends StatelessWidget {
  final _mainScaffoldKey = GlobalKey<ScaffoldState>();

  PageController _mainPageController = PageController(initialPage: 0);

  List<String> pagesTitle = [
    "ESTOK APP",
    "HISTORICO",
    "MEU PERFIL",
  ];

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, snapshot, userModel) {
        return Scaffold(
          key: _mainScaffoldKey,
          appBar: CustomAppBar(
            titleText: pagesTitle[userModel.currentIndexMainPage],
            automaticallyImplyLeading: userModel.currentIndexMainPage == 0 ? true : false,
            showBorder: userModel.currentIndexMainPage == 0 ? false : true,
          ),
          body: PageView(
            onPageChanged: (index) {
              userModel.currentIndexMainPage = index;
              userModel.setState();
            },
            controller: _mainPageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              HistoryPage(),
              ProfilePage(logoutOnPressed),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            currentIndex: userModel.currentIndexMainPage,
            onTap: (index) {
              _mainPageController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 18,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_add_check,
                  size: 18,
                ),
                label: "Histórico",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  size: 19,
                ),
                label: "Perfil",
              )
            ],
          ),
          drawer: userModel.currentIndexMainPage == 0
              ? SafeArea(
                  child: Container(
                    width: 315,
                    child: Drawer(
                      child: CustomNavigationDrawer(
                        pageController: _mainPageController,
                        onPressed: logoutOnPressed,
                        mainContext: context,
                      ),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

 void logoutOnPressed(BuildContext context)  {

    UserModel.of(context).logout(onFail: (logoutError) {
      Message.onFail(
        scaffoldKey: _mainScaffoldKey,
        message: logoutError,
        seconds: 3,
      );
      return;
    }, onSuccess: () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
      return;
    });
  }
}
