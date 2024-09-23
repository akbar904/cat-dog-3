
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/screens/home_screen.dart';
import 'package:simple_app/cubits/text_cubit.dart';
import 'package:simple_app/models/text_model.dart';
import 'package:simple_app/widgets/text_display.dart';

class MockTextCubit extends MockCubit<TextModel> implements TextCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('Initial display shows Cat with clock icon', (WidgetTester tester) async {
			// Arrange
			final mockTextCubit = MockTextCubit();
			when(() => mockTextCubit.state).thenReturn(TextModel(text: 'Cat', icon: Icons.access_time));

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<TextCubit>.value(
						value: mockTextCubit,
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Tapping text changes it to Dog with person icon', (WidgetTester tester) async {
			// Arrange
			final mockTextCubit = MockTextCubit();
			when(() => mockTextCubit.state).thenReturn(TextModel(text: 'Cat', icon: Icons.access_time));
			whenListen(mockTextCubit, Stream.fromIterable([TextModel(text: 'Dog', icon: Icons.person)]));

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<TextCubit>.value(
						value: mockTextCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
