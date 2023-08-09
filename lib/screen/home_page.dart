// ignore_for_file: constant_identifier_names

part of './pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();
  final GlobalKey globalKeyThree = GlobalKey();
  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(HomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch) {
      sharedPreferences.setBool(
          HomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);
    }
    return isFirstLaunch;
  }

  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().getMovies();
    _isFirstLaunch().then((value) {
      if (value) {
        ShowCaseWidget.of(context)
            .startShowCase([globalKeyOne, globalKeyTwo, globalKeyThree]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget sectionTop() {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Choose Your\nMovie",
              style:
                  whiteTextStyle.copyWith(fontSize: 32, fontWeight: semiBold),
              textScaleFactor: context.textscale,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/profile_picture.png'))),
            ),
          ],
        ),
      );
    }

    Widget sectionHotMovie() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowCaseView(
              globalKey: globalKeyOne,
              title: "Hot Movies",
              description: "List for Hot Movies in the town",
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: Text(
                  "Hot Movies",
                  style: whiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                  textScaleFactor: context.textscale,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: cCream,
                    ),
                  );
                } else if (state is MovieFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.pushAndRemoveUntil(const ErrorPage());
                  });
                  return const SizedBox();
                } else if (state is MovieSuccess) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: state.dataMovie
                          .getRange(0, 5)
                          .map((item) => GestureDetector(
                                onTap: () {
                                  context.push(MovieDetailPage(item: item));
                                },
                                child: Container(
                                  width: 280,
                                  height: 400,
                                  margin: EdgeInsets.only(
                                      left: state.dataMovie.indexOf(item) == 0
                                          ? 24
                                          : 0,
                                      right: state.dataMovie.indexOf(item) ==
                                              state.dataMovie.length - 1
                                          ? 24
                                          : 20),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 280,
                                        height: 400,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: FadeInImage(
                                            fit: BoxFit.cover,
                                            placeholder: const AssetImage(
                                                'assets/loading.gif'),
                                            image: NetworkImage(item['poster']),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: 248,
                                          height: 57,
                                          margin: const EdgeInsets.only(
                                              left: 16, right: 16, bottom: 15),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 12.0, sigmaY: 12.0),
                                              child: Container(
                                                width: 248,
                                                height: 57,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 12),
                                                decoration: BoxDecoration(
                                                  color:
                                                      cWhite.withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: cWhite
                                                          .withOpacity(0.3)),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 220,
                                                          child: Text(
                                                            item['title'],
                                                            style: whiteTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        bold),
                                                            textScaleFactor:
                                                                context
                                                                    .textscale,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Release date: ${DateFormat('dd MMM yyyy', 'id_ID').format(
                                                            DateTime.parse(
                                                              item['created_date']
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          "T\\d+:\\d+:\\d+.\\d+\\+\\d+:\\d+"),
                                                                      ""),
                                                            ),
                                                          )}",
                                                          style: whiteTextStyle
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      medium),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: cCream,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    Widget sectionListMovies() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShowCaseView(
                    globalKey: globalKeyTwo,
                    title: "List Movie",
                    description: "List for all movies",
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "List Movies",
                      style: whiteTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                      textScaleFactor: context.textscale,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(const MovieListPage());
                    },
                    child: ShowCaseView(
                      globalKey: globalKeyThree,
                      title: "See all movies list",
                      description: "Click here for looking all movies list",
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "See more",
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium),
                        textScaleFactor: context.textscale,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
              if (state is MovieLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: cCream,
                  ),
                );
              } else if (state is MovieSuccess) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: state.dataMovie
                        .getRange(0, 9)
                        .map((item) => Container(
                              width: 150,
                              height: 180,
                              margin: EdgeInsets.only(
                                  left: state.dataMovie.indexOf(item) == 0
                                      ? 24
                                      : 0,
                                  right: state.dataMovie.indexOf(item) ==
                                          state.dataMovie.length - 1
                                      ? 24
                                      : 20),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 180,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        placeholder: const AssetImage(
                                            'assets/loading.gif'),
                                        image: NetworkImage(
                                            item['poster'] ?? noImage),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .push(MovieDetailPage(item: item));
                                      },
                                      child: Container(
                                        width: 135,
                                        height: 40,
                                        margin: const EdgeInsets.only(
                                            left: 16, right: 16, bottom: 15),
                                        decoration: BoxDecoration(
                                            color: cCream.withOpacity(0.75),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "View Detail",
                                            style: whiteTextStyle.copyWith(
                                                fontSize: 14, fontWeight: bold),
                                            textScaleFactor: context.textscale,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: cCream,
                  ),
                );
              }
            }),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTop(),
            sectionHotMovie(),
            sectionListMovies(),
          ],
        ),
      ),
    );
  }
}
