
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'lib/models/text_model.dart';

void main() {
	group('TextModel', () {
		test('should be instantiated with given text and icon', () {
			const text = 'Cat';
			const icon = Icons.access_time;

			final model = TextModel(text: text, icon: icon);

			expect(model.text, equals(text));
			expect(model.icon, equals(icon));
		});

		test('should support serialization to JSON', () {
			const text = 'Cat';
			const icon = Icons.access_time;

			final model = TextModel(text: text, icon: icon);
			final json = model.toJson();

			expect(json, equals({
				'text': text,
				'icon': icon.codePoint,
			}));
		});

		test('should support deserialization from JSON', () {
			const text = 'Cat';
			const iconCodePoint = Icons.access_time.codePoint;

			final json = {
				'text': text,
				'icon': iconCodePoint,
			};

			final model = TextModel.fromJson(json);

			expect(model.text, equals(text));
			expect(model.icon, equals(IconData(iconCodePoint, fontFamily: 'MaterialIcons')));
		});
	});
}
