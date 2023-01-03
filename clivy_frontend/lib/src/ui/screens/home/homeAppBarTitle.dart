import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/homeAppBar/homeAppBarCubit.dart';
import 'package:untitled_client/src/bloc/homeAppBar/homeAppBarState.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserBloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserState.dart';

class HomeAppBarTitle extends StatefulWidget {
  final String username;
  const HomeAppBarTitle({ 
    required this.username,
    Key? key 
  }) : super(key: key);
  // const HomeAppBarTitle({ Key? key }) : super(key: key);

  @override
  _HomeAppBarTitleState createState() => _HomeAppBarTitleState();
}

class _HomeAppBarTitleState extends State<HomeAppBarTitle> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

// class HomeAppBarTitle extends StatelessWidget {
  // final String username;
  // const HomeAppBarTitle({ 
  //   required this.username,
  //   Key? key 
  // }) : super(key: key);

  late String username;

  @override
  initState() {
    username = widget.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAppBarCubit, HomeAppBarState>(
      builder: (context, state) {
        double clivyOpacity = 1.0;
        double usernameOpacity = 0.0;
        double activityOpacity = 0.0;
        double createClipOpacity = 0.0;

        if (state is HomeAppBarChangePageState) {
          clivyOpacity = state.clivyOpacity;
          usernameOpacity = state.usernameOpacity;
          activityOpacity = state.activityOpacity;
          createClipOpacity = state.createClipOpacity;
        }
        
        return Stack(
          children: [
            AnimatedOpacity(
              opacity: clivyOpacity,
              duration: Duration(milliseconds: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  // color: Colors.red,
                  height: 42,
                  child: Image.asset("assets/images/clivy_isotype.png")
                ),
                // child: Container(
                //   child: Text(
                //     "Clivy",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 25,
                //       fontWeight: FontWeight.w800,
                //       height: 1
                //     )
                //   )
                // ),
              ),
            ),
            AnimatedOpacity(
              opacity: usernameOpacity,
              duration: Duration(milliseconds: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: BlocBuilder<EditUserBloc, EditUserState>(
                    builder: (context, state) {
                      if (state is EditUserUpdatedState) {
                        username = state.user.username;
                      }
                      return Text(
                        "$username",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1
                        )
                      );
                    }
                  )
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: activityOpacity,
              duration: Duration(milliseconds: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Activity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      height: 1
                    )
                  )
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: createClipOpacity,
              duration: Duration(milliseconds: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "New Clip",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      height: 1
                    )
                  )
                ),
              ),
            ),
          ]
        );
      }
    );
  }
}