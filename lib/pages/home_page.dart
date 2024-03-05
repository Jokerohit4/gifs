import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gifs/services/api_service.dart';
import 'package:gifs/services/helper_methods.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  int _c = 0;
  List imageUrls = [];
  List searchedImage = [];
  final _searchController = TextEditingController();
  final _helper = HelperMethods();

  @override
  void initState() {
    super.initState();
    getImages();
   searchBarOperation();
    scrollBarOperations();
  }

  void scrollBarOperations(){
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ++_c;
        getImages();
      }
    });
  }


  void searchBarOperation(){
     _searchController.addListener(() {
      searchedImage = [];
      for (int i = 0; i < imageUrls.length; i++) {
        String imageKeyword = imageUrls[i]["keyword"];
        if (imageKeyword.contains(_searchController.text)) {
          searchedImage.add(imageUrls[i]);
        }
      }
      setState(() {});
    });
  }

  Future<void> getImages() async {
    imageUrls = await ApiService.fetchGifs(_c);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: searchBar(),
        actions: [
          changeThemeButton()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
            itemCount:
            searchedImage.isEmpty ? imageUrls.length : searchedImage.length,
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 100 / 120,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              String imageUrl = searchedImage.isEmpty
                  ? imageUrls[index]['imgUrl']
                  : searchedImage[index]['imgUrl'];
              return CachedNetworkImage(
                width: 10,
                height: 10,
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            }),
      ),
    );
  }

  Widget searchBar(){
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 20,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: TextField(
        controller: _searchController,
      ),
    );
  }

  Widget changeThemeButton(){
    return TextButton(
        onPressed: () {
          setState(() {
            _helper.changeTheme();
          });
        },
        child: const Text(
          "Change Theme",
          style: TextStyle(color: Colors.white),
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
