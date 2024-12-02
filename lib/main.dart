import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/image_repository.dart';
import 'bloc/image_bloc/image_bloc.dart';
import 'bloc/image_bloc/image_event.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'picsum_api_image_fetch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => ImageBloc(ImageRepository())..add(FetchImages(1)),
        child: HomeScreen(),
      ),

    );
  }
}
