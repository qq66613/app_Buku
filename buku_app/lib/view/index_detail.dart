import 'package:buku_app/controllers/book_controls.dart';
import 'package:buku_app/view/image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBook extends StatefulWidget {
  const DetailBook({
    super.key,
    required this.isbn,
  });
  final String isbn;

  @override
  State<DetailBook> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  BookControl? controlDetail;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    controlDetail = Provider.of<BookControl>(context, listen: false);
    controlDetail!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        backgroundColor: const Color(0xff44000000),
        elevation: 0,
        title: const Center(
          child: Text("Details Books"),
        ),
      ),
      body: Consumer<BookControl>(builder: (context, controllers, child) {
        return controlDetail!.detailResponse == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageViewScreen(
                                imageUrl: controlDetail!.detailResponse!.image!,
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          controlDetail!.detailResponse!.image!,
                          height: 180,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controlDetail!.detailResponse!.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                controlDetail!.detailResponse!.subtitle!,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Authors : ${controlDetail!.detailResponse!.authors!}",
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                controlDetail!.detailResponse!.price!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 58, 107, 60)),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(Icons.star,
                                      color: index <
                                              int.parse(controlDetail!
                                                  .detailResponse!.rating!)
                                          ? const Color.fromARGB(
                                              200, 255, 255, 4)
                                          : Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () async {
                          Uri uri =
                              Uri.parse(controlDetail!.detailResponse!.url!);
                          try {
                            (await canLaunchUrl(uri))
                                ? launchUrl(uri)
                                // ignore: avoid_print
                                : print("Not Success");
                            // ignore: empty_catches
                          } catch (e) {}
                        },
                        child: const Text('Buy'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(controlDetail!.detailResponse!.desc!),
                  ),
                  const Divider(),
                  controlDetail!.simliarResponse == null
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            //shrinkWrap: true,
                            itemCount:
                                controlDetail!.simliarResponse!.books!.length,
                            //physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final current =
                                  controlDetail!.simliarResponse!.books![index];
                              return SizedBox(
                                width: 100,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        current.image!,
                                        height: 100,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            current.title!,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ]),
                              );
                            },
                          ),
                        )
                ],
              );
      }),
    );
  }
}
