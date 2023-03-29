import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_user_account_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Meu Perfil"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomUserAccountHeader(
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
                accountName: "JOAO DA SILVA FERNANDES",
                accountEmail: "joaosilva@gmail.com",
                circleAvatarImage: "assets/images/perfil_image.png",
                padding: EdgeInsets.only(top: 70),
              ),
              Divider(),
              Text("89323265"),Text("email.com.br"), CustomButton(onPressed:(){} ,textButton: "Sair",)
            ],
          ),
        ),
      ),
    );
  }
}
