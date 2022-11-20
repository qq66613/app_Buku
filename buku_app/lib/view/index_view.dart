import 'package:buku_app/controllers/book_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index_detail.dart';

class ViewDetail extends StatefulWidget {
  const ViewDetail({super.key});

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  BookControl? bookControl;

  @override
  void initState() {
    super.initState();
    bookControl = Provider.of<BookControl>(context, listen: false);
    bookControl!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        backgroundColor: const Color(0xff44000000),
        elevation: 0,
        title: const Center(
          child: Text("List Books"),
        ),
      ),
      body: Consumer<BookControl>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controllers, child) => Container(
          child: bookControl!.booklist == null
              ? child
              : ListView.builder(
                  itemCount: bookControl!.booklist!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBox = bookControl!.booklist!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailBook(
                              isbn: currentBox.isbn13!,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.network(
                            currentBox.image!,
                            height: 150,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentBox.title!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(currentBox.subtitle!),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      currentBox.price!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
