import 'package:estok_app/enums/stock_status_enum.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/tabs/em_aviso_tab.dart';
import 'package:estok_app/ui/tabs/em_estoque_tab.dart';
import 'package:estok_app/ui/tabs/em_falta_tab.dart';
import 'package:estok_app/ui/tabs/todos_tab.dart';
import 'package:estok_app/ui/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:estok_app/enums/extensions/stock_status_enum_extension.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
              unselectedLabelColor: Theme.of(context).textTheme.headline4.color,
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
              controller: tabController,
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
              controller: tabController,
              children: [
                TodosTab(StockStatusEnum.TODOS.stringValue),
                EmEstoqueTab(StockStatusEnum.EM_ESTOQUE.stringValue),
                EmAvisoTab(StockStatusEnum.EM_AVISO.stringValue),
                EmFaltaTab(StockStatusEnum.EM_FALTA.stringValue),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(StockAddPage()),
    );
  }
}
