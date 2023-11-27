import 'package:flutter/material.dart';

import '../models/novel.dart';
import '../pages/novel_read_page.dart';

class NovelSCarousel extends StatelessWidget {
  const NovelSCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final novels = Novel.fetchAll();
    return Container(
      height: 280,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    minChildSize: 0.5,
                    maxChildSize: 0.8,
                    builder: (_, controller) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              novels[index].image,
                              height: 120.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            novels[index].judul,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const Divider(color: Colors.grey),
                          Expanded(
                            child: ListView(
                              controller: controller,
                              children: novels[index]
                                  .chapters
                                  .map(
                                    (chap) => InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                          8.0,
                                        ),
                                        margin: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              chap.chapterke,
                                              style: TextStyle(
                                                color: Colors.grey[850],
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/ic003.png',
                                              height: 10.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NovelReadPage(
                                              chapters: chap,
                                              novel: novels[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 210,
              decoration: BoxDecoration(
                // color: const Color.fromRGBO(231, 222, 208, 0.3),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      novels[index].image,
                      height: 200.0,
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          novels[index].judul,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Divider(),
                        ),
                        Text(
                          novels[index].chapters.length.toString() + " Halaman",
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 25.0),
        itemCount: novels.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      ),
    );
  }
}
