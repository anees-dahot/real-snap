// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:real_snap/controller/user_profile_controller.dart';
// import '../../constants.dart';
// import '../widgets/cusotm_button.dart';

// class ChangeNameScreen extends StatefulWidget {
//   ChangeNameScreen({super.key});

//   @override
//   State<ChangeNameScreen> createState() => _ChangeNameScreenState();
// }

// class _ChangeNameScreenState extends State<ChangeNameScreen> {
  

//   ProfileController profileController = ProfileController();

//   @override
//   Widget build(BuildContext context) {
//     final height = Get.height;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         title: const Text('Change user name'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                   hintText: 'Write name',
//                   // icon: const Icon(Icons.search),
//                   // labelText: 'Searc',
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: const BorderSide(color: borderColor)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: const BorderSide(color: borderColor))),
//               onTapOutside: (event) =>
//                   FocusManager.instance.primaryFocus?.unfocus(),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             CustomButton(
//                 title: 'Change',
//                 onTap: () {
//                   profileController.changeUserName(_nameController.text);
//                   Get.back();
                
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
