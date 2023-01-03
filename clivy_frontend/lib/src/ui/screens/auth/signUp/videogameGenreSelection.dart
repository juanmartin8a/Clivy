import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesCubit.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesState.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';

class VideogameGenreSelection extends StatefulWidget {
  const VideogameGenreSelection({ Key? key }) : super(key: key);

  @override
  _VideogameGenreSelectionState createState() => _VideogameGenreSelectionState();
}

class _VideogameGenreSelectionState extends State<VideogameGenreSelection> {

  VideogamesCubit? _videogamesCubit;
  List<AllVideogameGenres$Query$VideogameGenre> allVideogameGenres = [];

  List selectedGenres = [];

  bool isLoading = false;
  

  @override
  void initState() {
    _videogamesCubit = BlocProvider.of<VideogamesCubit>(context);
    _videogamesCubit!.stream.listen((state) {
      if (state is FetchVideogameGenresState) {
        allVideogameGenres = state.videogameGenres.allVideogameGenres;
        if (mounted) {
          setState(() {});
        }
      } else if (state is SelectVideogameGenreState) {
        selectGenre(state.id, !state.isSelect);
        if (mounted) {
          setState(() {});
        }
      } else if (state is AddUserInterestsState) {
        isLoading = false;
        if (mounted) {
          setState(() {});
        }
      }
    });
    _videogamesCubit!.fetchVideogameGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 45,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            ),
            Container(
              child: Text(
                "Choose your interests",
                style: TextStyle(
                  color: Color(0xff00ff03),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  // height: 1
                ),
              )
            ),
            SizedBox(
              height: 8
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                "Choose the videogame genres you are the most into for personalized clip recommendations",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],//Color(0xff00ff03),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.2
                ),
              )
            ),
            SizedBox(
              height: 30
            ),
            Container(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ...allVideogameGenres.map((value) {
                    return GestureDetector(
                      onTap: () {
                        _videogamesCubit!.selectVideogameGenre(
                          value.id.toString(), 
                          selectedGenres.contains(value.id.toString()) ? true : false
                        );
                      },
                      child: Container(
                        // margin: EdgeInsets
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: selectedGenres.contains(value.id.toString()) ? Color(0xff00ff03) : Colors.grey[900]!, 
                            width: 2.0
                          ),
                        ),
                        child: Text(
                          value.videogameGenre,
                          style: TextStyle(
                            color: selectedGenres.contains(value.id.toString()) ? Color(0xff00ff03) : Colors.grey[850]!, //Color(0xff00ff03),
                            fontSize: 15,
                            // letterSpacing: 0.5,
                            // fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            height: 1.2
                          ),
                        )
                      ),
                    );
                  }).toList()
                ],
              )
            ),
            SizedBox(
              height: 30
            ),
            GestureDetector(
              onTap: () {
                // BlocProvider.of<SignUpCubit>(context).next(1, birthdayDate);
                List<int> newSelectedGenresList = selectedGenres.map((data) => int.parse(data)).toList();
                print(newSelectedGenresList);
                _videogamesCubit!.addUserInterests(newSelectedGenresList);
                isLoading = true;
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container( 
                width: MediaQuery.of(context).size.width * 0.5,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: selectedGenres.length > 0 ? Color(0xff00ff03) : Colors.grey[900]!, 
                    width: 2.0
                  ),
                ),
                child: Center(
                  child: !isLoading ? Text(
                    'Done',
                    style: TextStyle(
                      color: selectedGenres.length > 0 ? Color(0xff00ff03) : Colors.grey[800]!,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1
                    )
                  ) : Loader(padding: EdgeInsets.zero),
                )
              ),
            ),
            SizedBox(
              height: 30
            ),
          ]
        ),
      )
    );
  }

  void selectGenre(String id, bool exists) {
    if (exists) {
      selectedGenres.removeWhere((val) => val == id); 
      selectedGenres.toSet().toList();
    } else {
      selectedGenres.add(id);
      selectedGenres.toSet().toList();
    }
  }
}