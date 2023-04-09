import 'package:estok_app/entities/user.dart';
import 'package:estok_app/enums/upload_progress_enum.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class ProfilePage extends StatelessWidget {
  final _profileScaffoldKey = GlobalKey<ScaffoldState>();
  final void Function(BuildContext) onPressed;

  ProfilePage(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _profileScaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25, top: 75, bottom: 60),
          width: double.infinity,
          child: FutureBuilder<User>(
            future: UserRepository.instance.getUser(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/perfil_image.png"),
                    radius: 40,
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data.name.toUpperCase() : "",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data.email : "",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .textTheme
                          .bodyText2
                          .color,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    height: 2.5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.phone,
                            size: 20,
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            snapshot.hasData ? snapshot.data.telephone : "",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2
                                  .color,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.email,
                            size: 20,
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            snapshot.hasData ? snapshot.data.email : "",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2
                                  .color,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                    onPressed: () => onPressed(context),
                    textButton: "Sair",
                    width: 100,
                    height: 45,
                    borderRadius: BorderRadius.circular(8),
                    colorText: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                    colorButton: Theme
                        .of(context)
                        .primaryColor,
                    fontSize: 14,
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
