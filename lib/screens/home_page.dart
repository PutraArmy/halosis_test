import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:halosistest/blocs/user_bloc/bloc.dart';
// import 'package:halosistest/blocs/users_bloc/bloc.dart';
import 'package:halosistest/models/users_model.dart';
import 'package:halosistest/theme/colors/light_colors.dart';
import 'package:halosistest/widgets/list_user_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsersModel usersList = UsersModel();
  UserBloc _userBloc = UserBloc();

  // int _pageSize = 6;

  int pageNumber = 1;
  bool initial = true;

  ScrollController _scrollController = ScrollController();

  final PagingController<int, DataUser> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageNumber = 1;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMoreOrders(context);
      }
    });

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUsersList(page: pageNumber));

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  getMoreOrders(BuildContext context) {
    print("get user list");

    int total = usersList.totalPages ?? 0;

    if (total > pageNumber) {
      _userBloc = BlocProvider.of<UserBloc>(context);
      _userBloc.add(GetUsersList(page: pageNumber + 1));
    }
    pageNumber += 1;
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      _userBloc = BlocProvider.of<UserBloc>(context);
      _userBloc.add(GetUsersList(page: "1"));

      // final isLastPage = usersList.data!.length < _pageSize;

      // if (isLastPage) {
      //   _pagingController.appendLastPage(usersList.data);
      // } else {
      //   final nextPageKey = pageKey + usersList.data!.length;
      //   _pagingController.appendPage(usersList.data, nextPageKey);
      // }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () => Get.offAndToNamed("/"),
            child: Icon(Icons.logout),
          ),
          Text("    "),
        ],
        iconTheme: IconThemeData(
          color: LightColors.mainColor, //change your color here
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UsersListError) {}
              if (state is UsersListWaiting) {
                print("Loading data");
              }
              if (state is UsersListSuccess) {
                if (state.usersList.data == null) {
                  // _lastDataFlashsaleBanner = true;
                  print("Tidak ada data");
                } else {
                  // usersList = state.usersList;

                  if (pageNumber <= 1) {
                    usersList = state.usersList;
                  } else {
                    for (var i = 0; i < usersList.data!.length; i++) {
                      usersList.data?.add(state.usersList.data!.elementAt(i));
                    }
                  }

                  print("masuk datanya beres" +
                      usersList.data!.length.toString());
                  // print("Code" + usersList.data!.elementAt(0).firstName);
                }
              }
            },
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: 200,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "List Users",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 25),
            Flexible(
              child: Container(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UsersListError) {
                      return Container();
                    } else if (state is UsersListWaiting) {
                      return SpinKitCircle(
                        color: LightColors.mainColor,
                        size: 25.0,
                      );
                    } else {
                      // return Container();
                      return usersList.data != null
                          ? Container(
                              child: ListView.builder(
                                controller: _scrollController,
                                // physics: NeverScrollableScrollPhysics(),
                                // shrinkWrap: true,
                                itemCount: usersList.data?.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListUserWidget(
                                        user: usersList.data!.elementAt(index),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/folder.png",
                                  width: 200,
                                ),
                                Text("Order Not Available")
                              ],
                            );
                      ;
                    }
                  },
                ),
              ),
            ),
            // ListUserWidget(),
            // ListUserWidget(),
            // ListUserWidget(),
          ],
        ),
      ),
    );
  }
}
