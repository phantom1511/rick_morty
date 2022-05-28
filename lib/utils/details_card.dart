import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assets.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard(
      {Key? key,
      this.image,
      this.name,
      this.status,
      this.type,
      this.location,
      this.gender})
      : super(key: key);
  final String? image;
  final String? name;
  final String? status;
  final String? type;
  final String? location;
  final String? gender;

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade50),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(75, 181, 241, 0.15),
            offset: Offset(0, 5),
            blurRadius: 8.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.image != null
                ? Center(
                    child: Image.network(
                      '${widget.image}',
                      width: 312,
                      height: 300,
                    ),
                  )
                : Center(
                    child: SvgPicture.asset(
                      Assets.avatar_m,
                      width: 312,
                      height: 300,
                    ),
                  ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Name',
              style: TextStyle(color: Colors.black45, fontSize: 10),
            ),
            Text(
              '${widget.name}',
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            const Text(
              'Gender',
              style: TextStyle(color: Colors.black45, fontSize: 10),
            ),
            Text(
              '${widget.gender}',
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            const Text(
              'Status',
              style: TextStyle(color: Colors.black45, fontSize: 10),
            ),
            Text(
              '${widget.status}',
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            const Text(
              'Type',
              style: TextStyle(color: Colors.black45, fontSize: 10),
            ),
            Text(
              '${widget.type}',
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            const Text(
              'Location',
              style: TextStyle(color: Colors.black45, fontSize: 10),
            ),
            Text(
              '${widget.location}',
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
