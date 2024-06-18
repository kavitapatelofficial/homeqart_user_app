import 'package:flutter/material.dart';

class SingleCategoryMenu extends StatelessWidget {
  const SingleCategoryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 10, top: 20),
          height: 80,
          width: 366,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 7, bottom: 9, left: 10),
                child: SizedBox(
                  height: 64,
                  width: 68,
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    foregroundImage:
                        NetworkImage('https://picsum.photos/200/300'),
                  ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4),
                    child: Text(
                      'Up to 20% OFF',
                      style: TextStyle(
                          color: Color(0xff31CC44),
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Fruits',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Reference site about Lorem Ipsum...',
                      softWrap: true,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color(0xff777A8C),
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(
                  right: 23,
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff191C24),
                  size: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
