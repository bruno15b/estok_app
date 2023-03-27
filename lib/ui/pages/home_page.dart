import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/pages/login_page.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/tabs/home_tab.dart';
import 'package:estok_app/ui/widgets/custom_user_account_drawer_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    StockModel.of(context).fetchStocks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        title: Text("ESTOK APP"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(93),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "TODOS"),
              Tab(text: "Em estoque"),
              Tab(text: "Em aviso"),
              Tab(text: "Em falta"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTab("TODOS"),
          HomeTab("EM ESTOQUE"),
          HomeTab("EM AVISO"),
          HomeTab("EM FALTA"),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              CustomUserAccountDrawerHeader(
                accountName: "User",
                accountEmail: "example@gmail.com",
                backgroundImage: "assets/images/perfil_background.png",
                circleAvatarImage: "assets/images/perfil_image.png",
                backgroundHeight: 203,
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                leading: Icon(
                  Icons.account_circle,
                  color: Color(0xFF949191),
                ),
                title: Text(
                  "Meu Perfil",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                leading: Icon(
                  Icons.store,
                  color: Color(0xFF949191),
                ),
                title: Text(
                  "Estoques",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                leading: Icon(
                  Icons.playlist_add_check,
                  color: Color(0xFF949191),
                ),
                title: Text(
                  "Histórico",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 135,
              ),
              Center(
                child: SizedBox(
                  height: 43,
                  width: 100,
                  child: ElevatedButton(
                    child: Text(
                      "Sair",
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    onPressed: () {
                      UserModel.of(context).logout();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:15 ,right:5 ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return StockAddPage();
                },
              ),
            );
          },
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
