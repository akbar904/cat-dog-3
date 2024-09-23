
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/text_cubit.dart';
import '../models/text_model.dart';

class TextDisplay extends StatelessWidget {
	final TextModel textModel;

	const TextDisplay({Key? key, required this.textModel}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: () {
				context.read<TextCubit>().toggleText();
			},
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Text(textModel.text),
					Icon(textModel.icon),
				],
			),
		);
	}
}
