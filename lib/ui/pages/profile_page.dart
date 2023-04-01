import 'package:estok_app/entities/user.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_user_account_header.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText:"MEU PERFIL",returnArrow: false,),
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
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    textStyleName: TextStyle(
                        color: Theme.of(context).accentColor,
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
                  ScopedModelDescendant<UserModel>(
                    builder: (context, snapshot,userModel) {
                      return CustomButton(
                        onPressed: () {
                          UserModel.of(context).logout();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return LoginPage();
                            }),
                          );
                          userModel.currentIndexPage = 0;
                        },
                        textButton: "Sair",
                        width: 100,
                        height: 43,
                        borderRadius: BorderRadius.circular(8),
                        colorText: Theme.of(context).scaffoldBackgroundColor,
                        colorButton: Theme.of(context).accentColor,
                      );
                    }
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
