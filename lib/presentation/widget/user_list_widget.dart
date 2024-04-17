import 'package:flutter/material.dart';

import '../../data/model/user_model.dart';
import '../../style/style.dart';

class UserListWidget extends StatelessWidget {
  final List<UserModel> data;
  const UserListWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber,
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
                      style:
                          Themes.customColor(12, fontWeight: FontWeight.w800),
                    ),
                    Text('Dari : ${data[index].city}',
                        style: Themes.customColor(12,
                            fontWeight: FontWeight.w800)),
                    Text('HP : ${data[index].phoneNumber}',
                        style: Themes.customColor(11)),
                    Text('Alamat : ${data[index].address}',
                        style: Themes.customColor(11)),
                  ],
                ),

                //
                const Positioned(top: 0, right: 0, child: Icon(Icons.person))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
