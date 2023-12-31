import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePicWidget extends StatelessWidget {
  ProfilePicWidget({Key? key, required this.profilePhotoUrl}) : super(key: key);
  String profilePhotoUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image(
                    image: NetworkImage(profilePhotoUrl),
                
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
