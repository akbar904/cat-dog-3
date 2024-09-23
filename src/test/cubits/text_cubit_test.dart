
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:simple_app/cubits/text_cubit.dart';

class MockTextCubit extends MockCubit<TextModel> implements TextCubit {}

void main() {
	group('TextCubit', () {
		late TextCubit textCubit;

		setUp(() {
			textCubit = TextCubit();
		});

		tearDown(() {
			textCubit.close();
		});

		test('initial state is TextModel with "Cat" and Icons.access_time', () {
			expect(textCubit.state.text, equals('Cat'));
			expect(textCubit.state.icon, equals(Icons.access_time));
		});

		blocTest<TextCubit, TextModel>(
			'emits TextModel with "Dog" and Icons.person when toggleText is called',
			build: () => textCubit,
			act: (cubit) => cubit.toggleText(),
			expect: () => [isA<TextModel>().having((model) => model.text, 'text', 'Dog').having((model) => model.icon, 'icon', Icons.person)],
		);

		blocTest<TextCubit, TextModel>(
			'emits TextModel with "Cat" and Icons.access_time when toggleText is called twice',
			build: () => textCubit,
			act: (cubit) {
				cubit.toggleText();
				cubit.toggleText();
			},
			expect: () => [
				isA<TextModel>().having((model) => model.text, 'text', 'Dog').having((model) => model.icon, 'icon', Icons.person),
				isA<TextModel>().having((model) => model.text, 'text', 'Cat').having((model) => model.icon, 'icon', Icons.access_time),
			],
		);
	});
}
