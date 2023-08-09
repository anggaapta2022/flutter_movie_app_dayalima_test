part of './pages.dart';

class MovieDetailPage extends StatelessWidget {
  final dynamic item;
  const MovieDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
          "Movie Detail",
          style: customTextStyle.copyWith(
              fontSize: 16, fontWeight: semiBold, color: cGreen),
          textScaleFactor: context.textscale,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(item['poster'] ?? noImage),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.width * 0.5,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          item['title'],
                          style: whiteTextStyle.copyWith(
                              fontSize: 18, fontWeight: semiBold),
                          textScaleFactor: context.textscale,
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        "Release date: ${DateFormat('dd MMM yyyy', 'id_ID').format(
                          DateTime.parse(
                            item['created_date'].replaceAll(
                                RegExp("T\\d+:\\d+:\\d+.\\d+\\+\\d+:\\d+"), ""),
                          ),
                        )}",
                        style: whiteTextStyle.copyWith(
                            fontSize: 12, fontWeight: medium),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Description Movies",
              style: greyTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Text(
              item['description'],
              style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ))
          ],
        ),
      ),
    );
  }
}
