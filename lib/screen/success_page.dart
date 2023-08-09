part of './pages.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/success.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Yeay, Add New Movie Success!",
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
                    "Back to Home",
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
