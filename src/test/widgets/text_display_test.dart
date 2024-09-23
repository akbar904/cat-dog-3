
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/widgets/text_display.dart';

class MockTextCubit extends Mock implements TextCubit {}

void main() {
	group('TextDisplay Widget Tests', () {
		late TextCubit textCubit;

		setUp(() {
			textCubit = MockTextCubit();
		});

		testWidgets('initially displays Cat with clock icon', (WidgetTester tester) async {
			final initialTextModel = TextModel(text: 'Cat', icon: Icons.access_time);
			when(() => textCubit.state).thenReturn(initialTextModel);

			await tester.pumpWidget(MaterialApp(
				home: Scaffold(
					body: TextDisplay(textModel: initialTextModel),
				),
			));

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after text is clicked', (WidgetTester tester) async {
			final initialTextModel = TextModel(text: 'Cat', icon: Icons.access_time);
			final newTextModel = TextModel(text: 'Dog', icon: Icons.person);

			when(() => textCubit.state).thenReturn(initialTextModel);
			whenListen(textCubit, Stream.fromIterable([newTextModel]));

			await tester.pumpWidget(MaterialApp(
				home: Scaffold(
					body: BlocProvider.value(
						value: textCubit,
						child: TextDisplay(textModel: initialTextModel),
					),
				),
			));

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
