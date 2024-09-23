
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/models/text_model.dart';

class TextCubit extends Cubit<TextModel> {
	TextCubit() : super(TextModel(text: 'Cat', icon: Icons.access_time));

	void toggleText() {
		if (state.text == 'Cat') {
			emit(TextModel(text: 'Dog', icon: Icons.person));
		} else {
			emit(TextModel(text: 'Cat', icon: Icons.access_time));
		}
	}
}
