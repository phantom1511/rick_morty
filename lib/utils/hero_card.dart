import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assets.dart';

class HeroCard extends StatefulWidget {
  const HeroCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.gender,
      this.onPressDetails})
      : super(key: key);
  final String? imageUrl;
  final String? name;
  final String? gender;
  final VoidCallback? onPressDetails;

  @override
  State<HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressDetails,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(75, 181, 241, 0.15),
                    offset: Offset(0, 5),
                    blurRadius: 8.0,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widget.imageUrl != null
                        ? Image.network(
                            '${widget.imageUrl}',
                            width: 86,
                            height: 86,
                          )
                        : SvgPicture.asset(
                            Assets.avatar_m,
                            height: 86,
                            width: 86,
                          ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text('${widget.name}',
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis)),
                          const SizedBox(height: 4),
                          Text(
                            '${widget.gender}',
                            style: const TextStyle(color: Colors.black45),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
