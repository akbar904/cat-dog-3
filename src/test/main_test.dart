
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'lib/main.dart'; // Only import the file we are testing

class MockTextCubit extends MockCubit<TextModel> implements TextCubit {}

void main() {
	group('Main', () {
		testWidgets('App initializes correctly with initial state', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});
	
	group('TextCubit', () {
		late TextCubit textCubit;

		setUp(() {
			textCubit = MockTextCubit();
		});

		blocTest<TextCubit, TextModel>(
			'emits [TextModel(text: "Dog", icon: Icons.person)] when toggleText is called',
			build: () => textCubit,
			act: (cubit) => cubit.toggleText(),
			expect: () => [TextModel(text: 'Dog', icon: Icons.person)],
		);
	});

	group('HomeScreen', () {
		testWidgets('Displays initial text and icon', (WidgetTester tester) async {
			await tester.pumpWidget(BlocProvider(
				create: (_) => TextCubit(),
				child: MaterialApp(home: HomeScreen()),
			));

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Toggles text and icon on tap', (WidgetTester tester) async {
			final textCubit = MockTextCubit();
			whenListen(
				textCubit,
				Stream.fromIterable([TextModel(text: 'Dog', icon: Icons.person)]),
				initialState: TextModel(text: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(BlocProvider(
				create: (_) => textCubit,
				child: MaterialApp(home: HomeScreen()),
			));

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
