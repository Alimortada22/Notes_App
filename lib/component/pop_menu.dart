import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopMenu extends StatelessWidget {
   PopMenu({super.key,required this.onEditeTap,required this.onDeleteTap});
void Function(int index)? onEditeTap;
void Function()? onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: (){
          onEditeTap;
        }, child: const Text("Edite")),
        TextButton(onPressed: onDeleteTap, child: const Text("Delete")),
      ],
    );
  }
}
