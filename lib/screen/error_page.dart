part of './pages.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Oops, something error",
              style:
                  whiteTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
              textScaleFactor: context.textscale,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                context.pushAndRemoveUntil(ShowCaseWidget(
                    builder: Builder(builder: (context) => const HomePage())));
              },
              child: Container(
                width: context.width * 0.3,
                height: 40,
                decoration: BoxDecoration(
                  color: cCream,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Try Again",
                    style: whiteTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
