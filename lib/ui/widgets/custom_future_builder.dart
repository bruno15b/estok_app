import 'package:flutter/material.dart';

import 'message.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<List<T>> futureList;
  final Widget Function(BuildContext, T) itemBuilder;
  final String connectionMessage;
  final String errorMessage;
  final String emptyMessage;
  final Function onRefresh;
  final List<T> Function(List<T>, String) filter;
  final String filterCategory;
  final EdgeInsetsGeometry padding;

  CustomFutureBuilder(
      {@required this.futureList,
      @required this.itemBuilder,
      @required this.onRefresh,
      this.connectionMessage = "Não foi possivel obter os dados necessários, sem conexão!",
      this.errorMessage = "Erro ao obter os dados!",
      this.emptyMessage = "Nenhum dado encontrado!",
      this.filter,
      this.filterCategory,
      this.padding = const EdgeInsets.only(left: 10, right: 10, top: 29, bottom: 90)});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureList,
      builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Message(connectionMessage, onPressed: onRefresh, color: Theme.of(context).primaryColor);
          case ConnectionState.waiting:
            return Message.loading(context);
          default:
            if (snapshot.hasError) {
              return Message(errorMessage, onPressed: onRefresh, color: Theme.of(context).primaryColor);
            } else if (!snapshot.hasData) {
              return Message(errorMessage, onPressed: onRefresh, color: Theme.of(context).primaryColor);
            } else if (snapshot.data.isEmpty) {
              return Message(emptyMessage, color: Theme.of(context).primaryColor);
            } else {
              List<T> filteredList =
                  filter != null && filterCategory != null ? filter(snapshot.data, filterCategory) : snapshot.data;

              return RefreshIndicator(
                onRefresh: () async {
                  onRefresh();
                },
                child: ListView.builder(
                  padding: padding,
                  itemCount: filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemBuilder(context, filteredList[index]);
                  },
                ),
              );
            }
        }
      },
    );
  }
}
