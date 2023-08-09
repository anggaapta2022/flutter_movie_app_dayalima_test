part of './pages.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({super.key});

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  TextEditingController nameMovieController = TextEditingController();
  TextEditingController descriptionMovieController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  String selectedImagePath = '';

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget sectionInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Movie Name",
                style: greyTextStyle.copyWith(fontSize: 12, fontWeight: medium),
                textScaleFactor: context.textscale,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameMovieController,
                cursorColor: cCream,
                style:
                    whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
                validator: (value) {
                  if (value == "") {
                    return "Movie Name can't empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.only(left: 20),
                  hintText: "movie name",
                  hintStyle: greyTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cRed),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cCream),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cCream),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Description Movies",
                style: greyTextStyle.copyWith(fontSize: 12, fontWeight: medium),
                textScaleFactor: context.textscale,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionMovieController,
                cursorColor: cCream,
                style:
                    whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
                maxLines: 4,
                validator: (value) {
                  if (value == "") {
                    return "Description Movie can't empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.only(left: 20),
                  hintText: "description movie",
                  hintStyle: greyTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cRed),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cCream),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: cCream),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Select Image",
                style: greyTextStyle.copyWith(fontSize: 12, fontWeight: medium),
                textScaleFactor: context.textscale,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => pickImage(),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: selectedImagePath.isEmpty
                            ? cGrey
                            : Colors.transparent),
                  ),
                  child: selectedImagePath.isEmpty
                      ? Center(
                          child: Icon(
                            LucideIcons.plus,
                            size: 38,
                            color: cGrey,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(selectedImagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: cCream,
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      final isValidForm = formKey.currentState!.validate();
                      if (isValidForm) {
                        context
                            .read<MovieCubit>()
                            .insertMovies(
                                nameMovieController.text,
                                descriptionMovieController.text,
                                selectedImagePath)
                            .whenComplete(() async {
                          await context
                              .read<MovieCubit>()
                              .getMovies()
                              .whenComplete(() {
                            context.pushAndRemoveUntil(const SuccessPage());
                          });
                        });
                      }
                    },
                    child: Container(
                      width: context.width * 1,
                      height: 45,
                      decoration: BoxDecoration(
                        color: cCream,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Submit Movie",
                          style: whiteTextStyle.copyWith(
                              fontSize: 14, fontWeight: semiBold),
                          textScaleFactor: context.textscale,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
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
          "Add Movie",
          style: customTextStyle.copyWith(
              fontSize: 16, fontWeight: semiBold, color: cGreen),
          textScaleFactor: context.textscale,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionInput(),
            ],
          ),
        ),
      ),
    );
  }
}
