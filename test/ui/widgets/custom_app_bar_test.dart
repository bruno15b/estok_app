
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("CustomAppBar deve ser criado", (WidgetTester tester) async {

    await tester.pumpWidget(
         MaterialApp(
          home: Scaffold(
            body: CustomAppBar(titleText:"Menu"),
          ),
        ),
    );

    final titleTextFinder = find.text("Menu");
    final appBarFinder = find.byType(AppBar);

    expect(titleTextFinder, findsOneWidget);
    expect(appBarFinder, findsOneWidget);
  });


  testWidgets("CustomAppBar deve ser renderizado sem o botão de voltar quando automaticallyImplyLeading for false'", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomAppBar(titleText: "Test Title", automaticallyImplyLeading: false)));

    expect(find.byType(Icon), findsNothing);
  });

  testWidgets("CustomAppBar deve centralizar o texto do título quando centerTitle for verdadeiro.", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomAppBar(titleText:"Test Title",)));

    final titleTextWidget = tester.widget<Text>(find.byType(Text));

    expect(titleTextWidget.textAlign, equals(TextAlign.center));
  });

}


