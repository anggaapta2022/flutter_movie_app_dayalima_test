part of './pages.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    Widget sectionMovieList() {
      return BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
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
          return SizedBox(
            // height: context.height * 0.3,
            child: ListView.builder(
              itemCount: state.dataMovie.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < state.dataMovie.length) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/loading.gif'),
                              image: NetworkImage(
                                  state.dataMovie[index]['poster'] ?? noImage),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: context.width * 0.5,
                                child: Text(
                                  state.dataMovie[index]['title'],
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                  textScaleFactor: context.textscale,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Release date: ${DateFormat('dd MMM yyyy', 'id_ID').format(
                                  DateTime.parse(
                                    state.dataMovie[index]['created_date']
                                        .replaceAll(
                                            RegExp(
                                                "T\\d+:\\d+:\\d+.\\d+\\+\\d+:\\d+"),
                                            ""),
                                  ),
                                )}",
                                style: whiteTextStyle.copyWith(
                                    fontSize: 12, fontWeight: medium),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push(MovieDetailPage(
                                      item: state.dataMovie[index]));
                                },
                                child: Text(
                                  "View Detail",
                                  style: customTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: medium,
                                      color: cCream),
                                  textScaleFactor: context.textscale,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state.reachMax == true) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Text(
                        "No more movies",
                        style: greyTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      ),
                    ),
                  );
                } else {
                  Timer(const Duration(milliseconds: 1500), () {
                    context.read<MovieCubit>().getMovies();
                  });
                  return Center(
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: CircularProgressIndicator(color: cCream)));
                }
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(color: cCream),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(
            LucideIcons.chevronLeft,
            size: 24,
            color: cGreen,
          ),
        ),
        title: Text(
          "Movie List",
          style: customTextStyle.copyWith(
              fontSize: 16, fontWeight: semiBold, color: cGreen),
          textScaleFactor: context.textscale,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const AddMoviePage());
        },
        backgroundColor: cCream,
        child: Icon(
          LucideIcons.plus,
          size: 32,
          color: cWhite,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: sectionMovieList(),
            ),
          ],
        ),
      ),
    );
  }
}
