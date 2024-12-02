import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/image_bloc/image_bloc.dart';
import '../../bloc/image_bloc/image_event.dart';
import '../../bloc/image_bloc/image_state.dart';
import '../widgets/image_grid.dart';
import '../widgets/image_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = true; // Toggle state for view type

  @override
  Widget build(BuildContext context) {
    final imageBloc = BlocProvider.of<ImageBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView; // Toggle view type
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading && state is! ImageLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ImageLoaded || state is ImagePaginationLoading) {
            final isPaginating = state is ImagePaginationLoading;

            // Use GridView or ListView based on the toggle
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    state is ImageLoaded &&
                    state.hasMore) {
                  imageBloc.add(FetchImages(imageBloc.currentPage + 1));
                }
                return true;
              },
              child: isGridView
                  ? ImageGrid(
                      images: state.images,
                      isPaginating: isPaginating,
                    )
                  : ImageList(
                      images: state.images,
                      isPaginating: isPaginating,
                    ),
            );
          } else if (state is ImageError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Start Fetching Images'));
        },
      ),
    );
  }
}
