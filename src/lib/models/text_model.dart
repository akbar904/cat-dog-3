
import 'package:flutter/material.dart';

class TextModel {
	final String text;
	final IconData icon;

	const TextModel({required this.text, required this.icon});

	Map<String, dynamic> toJson() {
		return {
			'text': text,
			'icon': icon.codePoint,
		};
	}

	factory TextModel.fromJson(Map<String, dynamic> json) {
		return TextModel(
			text: json['text'] as String,
			icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
		);
	}
}
