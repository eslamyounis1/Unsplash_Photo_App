import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/shared/network/remote/repositories.dart';
import 'package:photo_app/models/models.dart';


class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  String _query = 'programming';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
        ),
        body: GestureDetector(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      _query = value.trim();
                    });
                  }
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: PhotosRepository().searchPhotos(query: _query),
                  builder:(context,snapshot){
                    if (snapshot.connectionState == ConnectionState.done){

                      final Photo photos = snapshot.data;
                      print(photos);
                      return Container();


                    }
                    return const Center(child: CircularProgressIndicator(),);

                  } ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
