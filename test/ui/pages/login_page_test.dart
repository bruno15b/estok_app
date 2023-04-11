import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/pages/login_page.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {

  testWidgets("Campos de e-mail e senha devem ser exibidos", (WidgetTester tester) async {
    await tester.pumpWidget(
      ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          home: Scaffold(
            body: LoginPage(),
          ),
        ),
      ),
    );
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('Validação de e-mail deve funcionar corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          home: Scaffold(
            body: LoginPage(),
          ),
        ),
      ),
    );

    final firstCustomTextFormField = find.byType(CustomTextFormField).at(0);

    await tester.tap(firstCustomTextFormField);
    await tester.pumpAndSettle();

    await tester.enterText(firstCustomTextFormField, 'eemail.comasdhgdasdas');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final customButton = find.byType(CustomButton);
    await tester.tap(customButton);
    await tester.pumpAndSettle();

    expect(find.text("Email inválido"), findsOneWidget);

    await tester.enterText(firstCustomTextFormField, 'email@exemplo.com');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(customButton);
    await tester.pumpAndSettle();

    expect(find.text("Email inválido"), findsNothing);
  });

  testWidgets('Validação de senha deve funcionar corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          home: Scaffold(
            body: LoginPage(),
          ),
        ),
      ),
    );

    final secondCustomTextFormField = find.byType(CustomTextFormField).at(1);

    await tester.tap(secondCustomTextFormField);
    await tester.pumpAndSettle();

    await tester.enterText(secondCustomTextFormField, "123");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();


    final customButton = find.byType(CustomButton);
    await tester.tap(customButton);
    await tester.pumpAndSettle();

    expect(find.text("Campo deve conter no mínimo 5 caracteres"), findsOneWidget);

    await tester.enterText(secondCustomTextFormField, "senhavalida");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(customButton);
    await tester.pumpAndSettle();

    expect(find.text("Campo deve conter no mínimo 5 caracteres"), findsNothing);
  });

}