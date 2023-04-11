import 'package:estok_app/entities/user.dart';
import 'package:estok_app/enums/progress_enum.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'custom_button.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final PageController pageController;
  final void Function(BuildContext) onPressed;
  final BuildContext mainContext;

  CustomNavigationDrawer({@required this.pageController, @required this.onPressed, @required this.mainContext});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder<User>(
            future: UserRepository.instance.getUser(),
            builder: (context, snapshot) {
              return Container(
                height: 240,
                child: DrawerHeader(
                  padding: EdgeInsets.only(top: 50, left: 32, bottom: 32),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/perfil_background.png"), fit: BoxFit.cover),
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
          onTap: () {
            Navigator.of(context).pop();
            pageController.jumpToPage(2);
          },
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
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
          },
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
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            pageController.jumpToPage(1);
          },
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
        ),
        SizedBox(
          height: 135,
        ),
        Center(
          child: CustomButton(
              onPressed: (){
                Navigator.of(context).pop();
                onPressed(mainContext);
              },
              textButton: "Sair",
              width: 100,
              height: 45,
              borderRadius: BorderRadius.circular(8),
              colorText: Theme.of(context).scaffoldBackgroundColor,
              colorButton: Theme.of(context).primaryColor,
              fontSize: 14,
            ),
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}
