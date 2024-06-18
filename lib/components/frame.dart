import 'package:flutter/material.dart';

class Frame1 extends StatelessWidget {
  const Frame1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 10, top: 20),
          height: 105,
          width: 95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.black12)),
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 5, right: 17, left: 17),
                child: SizedBox(
                  height: 61,
                  width: 61,
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    foregroundImage:
                        NetworkImage('https://picsum.photos/200/300'),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  'Grocery &\nStaples',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
