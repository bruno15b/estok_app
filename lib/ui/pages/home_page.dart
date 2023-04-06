import 'package:estok_app/enums/stock_status_enum.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/tabs/home_tab.dart';
import 'package:estok_app/ui/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:estok_app/enums/extensions/stock_status_enum_extension.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 54, bottom: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.3,
                ),
              ),
            ),
            child: TabBar(
              labelPadding: EdgeInsets.only(top: 0, bottom: 0),
              unselectedLabelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 2,
              ),
              unselectedLabelColor: Color(0xFF909FAD),
              labelColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 2,
              ),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.5,
                  ),
                ),
              ),
              controller: _tabController,
              tabs: [
                Tab(text: "TODOS"),
                Tab(text: "Em estoque"),
                Tab(text: "Em aviso"),
                Tab(text: "Em falta"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomeTab(StockStatusEnum.TODOS.stringValue),
                HomeTab(StockStatusEnum.EM_ESTOQUE.stringValue),
                HomeTab(StockStatusEnum.EM_AVISO.stringValue),
                HomeTab(StockStatusEnum.EM_FALTA.stringValue),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(StockAddPage()),
    );
  }
}
