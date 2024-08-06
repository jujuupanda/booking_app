import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditBuildingCardView extends StatelessWidget {
  const EditBuildingCardView({
    super.key,
    required this.name,
    required this.functionEdit,
    required this.functionDelete,
  });

  final String? name;
  final VoidCallback? functionEdit;
  final VoidCallback? functionDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                name!,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: functionEdit,
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: functionDelete,
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.delete),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
