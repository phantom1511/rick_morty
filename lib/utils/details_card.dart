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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.image != null
                ? Image.network(
                    '${widget.image}',
                    width: 312,
                    height: 312,
                  )
                : SvgPicture.asset(
                    Assets.avatar_m,
                    width: 312,
                    height: 312,
                  ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Text('${widget.name}'),
            const SizedBox(height: 8),
            Text('${widget.status}'),
            const SizedBox(height: 8),
            Text('${widget.type}'),
            const SizedBox(height: 8),
            Text('${widget.location}'),
            const SizedBox(height: 8),
            Text('${widget.gender}'),
          ],
        ),
      ),
    );
  }
}
