import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:untitled_client/src/bloc/gallery/galleryBloc.dart';
import 'package:untitled_client/src/bloc/gallery/galleryEvent.dart';
import 'package:untitled_client/src/bloc/gallery/galleryState.dart';
import 'package:untitled_client/src/bloc/gallery/loading/galleryLoadingCubit.dart';
import 'package:untitled_client/src/bloc/gallery/loading/galleryLoadingState.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> with AutomaticKeepAliveClientMixin {
  // final TextEditingController _captionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // final GraphQLClient _client = c.Client.client!;
  List<Widget> _widgetList = [];
  bool hasMore = true;
  int page = 0;
  bool loading = false;

  GalleryBloc? _galleryBloc;

  File? file;
  CustomMultipartFile? multipartFile;
  
  // MediaType? _mimetype;

  @override
  void initState() {
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
    PhotoManager.addChangeCallback(onChangeCallback);
    PhotoManager.startChangeNotify();
    initFetch();
    _scrollController.addListener(scrollListenerFunc);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    PhotoManager.removeChangeCallback((call) {});
    PhotoManager.stopChangeNotify();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50.0),
      //   child: AppBar(
      //     automaticallyImplyLeading: false,
      //     backgroundColor: Colors.black,
      //     // brightness: Brightness.dark,
      //     leading: GestureDetector(
      //       onTap: () {
      //         Get.back();
      //       },
      //       child: Container(
      //         child: FloatingActions(
      //           icon: EvaIcons.arrowBackOutline,
      //           size: 36,
      //           key: Key("goBack")
      //         ),
      //       ),
      //     ),
      //     title: Container(
      //       child: Text(
      //         'New Post',
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 20,
      //           fontWeight: FontWeight.w700
      //         )
      //       )
      //     )
      //   ),
      // ),
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 50 + MediaQuery.of(context).padding.top),
        child: BlocBuilder<GalleryBloc, GalleryState>(
          builder: (context, state) {
            if (state is GalleryLoadedState) {
              _widgetList = state.gallery.toSet().toList();
              hasMore = state.hasMore;
              page = state.page;
              loading = false;
            } else if (state is GalleryFileChoosenState) {
              file = state.file;
            }
            else if (state is GalleryFailedState) {
              loading = false;
            }
            return Column(
              children: [
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: _widgetList.length,
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 12/9,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3
                      ),
                      itemBuilder: (context, index) {
                        return _widgetList[index];
                      }
                    ),
                  ),
                ),
                BlocConsumer<GalleryLoadingCubit, GalleryLoadingState>(
                  listener: (context, state) {
                    if (state is GetGalleryLoadingState) {
                      loading = true;
                    } else if (state is GetGalleryLoadingState) {
                      loading = false;
                    }
                  },
                  builder: (context, state) {
                    return Container();
                  },
                )
              ],
            );
          },
        )
      )
    );
  }


  onChangeCallback(call) {
    if (loading == false) {
      if (call.arguments["delete"].isNotEmpty || call.arguments["create"].isNotEmpty) {
        _galleryBloc!.add(GalleryOnChangeEvent(
          page: page,
          widgetList: _widgetList,
          hasMore: hasMore
        ));
      }
    }
  }

  initFetch() {
    loading = true;
    _galleryBloc!.add(FetchFromGallery(
      page: page,
      widgetList: _widgetList,
    ));
  }

  scrollListenerFunc() {
    if (hasMore == true) {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height;
      if ((maxScroll - currentScroll) < delta) {
        if (loading == false) {
          loading = true;
          _galleryBloc!.add(FetchFromGallery(
            page: page,
            widgetList: _widgetList,
          ));
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}