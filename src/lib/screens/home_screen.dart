
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/cubits/text_cubit.dart';
import 'package:simple_app/widgets/text_display.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Simple App'),
			),
			body: Center(
				child: BlocBuilder<TextCubit, TextModel>(
					builder: (context, state) {
						return GestureDetector(
							onTap: () {
								context.read<TextCubit>().toggleText();
							},
							child: TextDisplay(textModel: state),
						);
					},
				),
			),
		);
	}
}
