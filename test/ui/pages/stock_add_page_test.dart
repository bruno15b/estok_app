import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';


void main() {

  testWidgets('StockAddPage foi construida corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScopedModel<StockModel>(
        model: StockModel(),
        child: MaterialApp(
          home: Scaffold(
            body: StockAddPage(),
          ),
        ),
      ),
    );

    expect(find.text('NOVO ESTOQUE'), findsOneWidget);
    expect(find.text('Descrição do estoque'), findsOneWidget);
    expect(find.text('Entrada'), findsOneWidget);
    expect(find.text('Saída'), findsOneWidget);
    expect(find.text('Tipo'), findsOneWidget);
    expect(find.text('CAIXA'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });

  testWidgets('O alertDialog deve abrir ao clicar no InkWell', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScopedModel<StockModel>(
        model: StockModel(),
        child: MaterialApp(
          home: Scaffold(
            body: StockAddPage(),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(ValueKey('typeButtom')));
    await tester.pump();

    final newWidget = find.byKey(ValueKey('dialogWidgetKey'));
    expect(newWidget, findsOneWidget);

    expect(find.text('CAIXA'), findsWidgets);
    expect(find.text('GRADE'), findsOneWidget);
    expect(find.text('PACOTE'), findsOneWidget);

    await tester.tap(find.text('GRADE').last);
    await tester.pump();

    expect(find.text('GRADE'), findsOneWidget);
  });

  testWidgets('Os CustomTextFormField devem ser preenchidos corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScopedModel<StockModel>(
        model: StockModel(),
        child: MaterialApp(
          home: Scaffold(
            body: StockAddPage(),
          ),
        ),
      ),
    );

    final firstCustomTextFormField = find.byType(CustomTextFormField).at(0);

    await tester.tap(firstCustomTextFormField);
    await tester.pumpAndSettle();

    await tester.enterText(firstCustomTextFormField, "Novo Estoque");

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text("Novo Estoque"), findsOneWidget);

    final secondCustomTextFormField = find.byType(CustomTextFormField).at(1);

    await tester.tap(secondCustomTextFormField);
    await tester.pumpAndSettle();
    await tester.enterText(secondCustomTextFormField, "10/10/2022");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text("10/10/2022"), findsOneWidget);

    final thirdCustomTextFormField = find.byType(CustomTextFormField).at(2);

    await tester.tap(thirdCustomTextFormField);
    await tester.pumpAndSettle();
    await tester.enterText(thirdCustomTextFormField, "10/10/2026");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text("10/10/2026"), findsOneWidget);
  });

  testWidgets('Ao clicar no botão deve aparecer três mensagens "Campo Vazio" ', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScopedModel<StockModel>(
        model: StockModel(),
        child: MaterialApp(
          home: Scaffold(
            body: StockAddPage(),
          ),
        ),
      ),
    );

    final customButton = find.byType(CustomButton);

    await tester.tap(customButton);
    await tester.pumpAndSettle();

    expect(find.text("Campo Vazio"), findsNWidgets(3));
  });


}

