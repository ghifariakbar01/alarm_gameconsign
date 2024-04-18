import 'package:flutter/material.dart';

import '../../data/model/user_model.dart';
import '../../style/style.dart';
import 'common_widget.dart';

class UserListWidget extends StatelessWidget {
  final List<UserModel> data;
  const UserListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Palette.outlineColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {},
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].name,
                      style: Themes.font(12, fontWeight: FontWeight.w800),
                    ),
                    Text('Dari : ${data[index].city}',
                        style: Themes.font(12, fontWeight: FontWeight.w800)),
                    smallSpace(),
                    Text('HP : ${data[index].phoneNumber}',
                        style: Themes.font(11, fontWeight: FontWeight.w500)),
                    Text('Alamat : ${data[index].address}',
                        style: Themes.font(11, fontWeight: FontWeight.w500)),
                  ],
                ),

                //
                const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
