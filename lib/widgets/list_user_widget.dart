import 'package:flutter/material.dart';
import 'package:halosistest/models/users_model.dart';

class ListUserWidget extends StatelessWidget {
  final DataUser user;
  const ListUserWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double widthCard = width - 40;
    final double heightCard = widthCard / 1.687;
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: widthCard,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            child: SizedBox.fromSize(
              size: Size.fromRadius(50), // Image radius
              child: Image.network(user.avatar ?? "",
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(user.firstName ?? ""),
                  Text(" "),
                  Text(user.lastName ?? ""),
                ],
              ),
              Text(
                user.email ?? "",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
