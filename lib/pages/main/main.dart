import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        rightIcon: Icon(Icons.more_vert),
        title: "부용고등학교 2학년 2반",
        date: "1월 1일 월요일",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top:10, left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.restaurant,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '오늘의 급식',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ),
                                ],
                              ),
                              Text(
                                '더보기',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                              )
                            ],
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.all(14),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "점심",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    )
                                  ),
                                  Text(
                                    "000.0kcal",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    )
                                  ),
                                ]
                              ),
                              SizedBox(height: 8),
                              Text(
                                "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)",
                                style: TextStyle(
                                  fontSize: 14,
                                )
                              )
                            ]
                          )
                        ),
                      ],
                    )
                  )
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.today,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '시간표',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ),
                                ],
                              ),
                              Text(
                                '더보기',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                              ),
                            ],
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "국어",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "2",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "수학",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "3",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "영어",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "4",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "화학I",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "5",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "물리I",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "6",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "지구과학I",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "7",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "생명과학I",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )
                                    ),
                                  ]
                                )
                              ),
                            ]
                          )
                        )
                      ]
                    )
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.rightIcon,
    required this.title,
    required this.date,
  });

  final Widget rightIcon;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      actions: [
        IconButton(
          icon: rightIcon,
          onPressed: () {},
        ),
      ],
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 64),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130.0);
}