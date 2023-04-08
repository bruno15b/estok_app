import 'package:estok_app/entities/user.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:estok_app/ui/pages/history_page.dart';
import 'package:estok_app/ui/pages/home_page.dart';
import 'package:estok_app/ui/pages/profile_page.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_page.dart';

class MainPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);

    List<String> pagesTitle = [
      "ESTOK APP",
      "HISTORICO",
      "MEU PERFIL",
    ];

    return ScopedModelDescendant<UserModel>(
      builder: (context, snapshot, userModel) {
        return Scaffold(
          key: _scaffoldKey,
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
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              HistoryPage(),
              ProfilePage(),
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
              _pageController.jumpToPage(index);
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
                      child: ListView(
                        children: [
                          FutureBuilder<User>(
                              future: UserRepository.instance.getUser(),
                              builder: (context, snapshot) {
                                return Container(
                                  height: 240,
                                  child: DrawerHeader(
                                    padding: EdgeInsets.only(top: 50, left: 32, bottom: 32),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/perfil_background.png"), fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: 42,
                                          child: Image.asset(
                                            "assets/images/perfil_image.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.hasData ? snapshot.data.name : "",
                                              style: TextStyle(
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.hasData ? snapshot.data.email : "",
                                              style: TextStyle(
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                            leading: Icon(
                              Icons.account_circle,
                              color: Theme.of(context).textTheme.headline4.color,
                            ),
                            title: Text(
                              "Meu Perfil",
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              _pageController.jumpToPage(2);
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                            leading: Icon(
                              Icons.store,
                              color: Theme.of(context).textTheme.headline4.color,
                            ),
                            title: Text(
                              "Estoques",
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                            leading: Icon(
                              Icons.playlist_add_check,
                              color: Theme.of(context).textTheme.headline4.color,
                            ),
                            title: Text(
                              "Histórico",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              _pageController.jumpToPage(1);
                            },
                          ),
                          SizedBox(
                            height: 135,
                          ),
                          Center(
                            child: CustomButton(
                              textButton: "Sair",
                              width: 100,
                              height: 45,
                              borderRadius: BorderRadius.circular(8),
                              colorText: Theme.of(context).scaffoldBackgroundColor,
                              colorButton: Theme.of(context).primaryColor,
                              fontSize: 14,
                              onPressed: () => logoutOnPressed(context),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  void logoutOnPressed(BuildContext context) {
    Navigator.of(context).pop();
    UserModel.of(context).logout(onFail: (logoutError) {
      Message.onFail(
          scaffoldKey: _scaffoldKey,
          message: logoutError,
          seconds: 3,
          onPop: (_) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route<dynamic> route) => false,
            );
          });
      return;
    }, onSuccess: () {
      Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: "Logout realizado com sucesso!Encerrando...",
          seconds: 3,
          onPop: (_) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route<dynamic> route) => false,
            );
          });
      return;
    });
  }
}
