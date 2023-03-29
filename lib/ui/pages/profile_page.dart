import 'package:estok_app/entities/user.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_user_account_header.dart';
import 'package:flutter/material.dart';

import 'history_page.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("MEU PERFIL"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          width: double.infinity,
          child: FutureBuilder<User>(
            future: UserRepository.instance.getUser(),
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomUserAccountHeader(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    backgroundHeight: 280,
                    textStyleEmail: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    textStyleName: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    spaceTextAvatar: 60,
                    accountName: snapshot.hasData ? snapshot.data.name : "",
                    accountEmail: snapshot.hasData ? snapshot.data.email : "",
                    circleAvatarImage: "assets/images/perfil_image.png",
                    padding: EdgeInsets.only(top: 70),
                  ),
                  Divider(),
                  SizedBox(
                    height: 29,
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data.telephone : "",
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data.email : "",
                  ),
                  SizedBox(
                    height: 71,
                  ),
                  CustomButton(
                    onPressed: () {
                      UserModel.of(context).logout();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return LoginPage();
                        }),
                      );
                    },
                    textButton: "Sair",
                    width: 100,
                    height: 43,
                    borderRadius: BorderRadius.circular(8),
                    colorText: Theme.of(context).scaffoldBackgroundColor,
                    colorButton: Theme.of(context).primaryColor,
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pop();
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => HistoryPage(),
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
