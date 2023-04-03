import 'package:estok_app/enums/stock_status.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/tabs/home_tab.dart';
import 'package:estok_app/ui/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

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
            padding: EdgeInsets.only(top: 60) ,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF58355E),
                    width: 6,
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
                HomeTab(StockStatus.TODOS.stringValue),
                HomeTab(StockStatus.EM_ESTOQUE.stringValue),
                HomeTab(StockStatus.EM_AVISO.stringValue),
                HomeTab(StockStatus.EM_FALTA.stringValue),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(StockAddPage()),
    );
  }
}
