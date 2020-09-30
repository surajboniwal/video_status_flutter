import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_status/controllers/account_controller.dart';
import 'package:video_status/data/models/single_video.dart';
import 'package:video_status/ui/theme/colors.dart';

Card buildCommentCard(comment) {
  return Card(
    elevation: 0,
    color: grey.withOpacity(0.2),
    child: ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      title: Text(
        comment.user,
        style: GoogleFonts.montserrat(),
      ),
      subtitle: Text(
        comment.comment,
        style: GoogleFonts.montserrat(),
      ),
      trailing: _buildCommentDeleteButton(comment),
    ),
  );
}

Widget _buildCommentDeleteButton(Comment comment) {
  if (getCurrentUser() != null) {
    if (getCurrentUser().displayName == comment.user) {
      return IconButton(onPressed: () {}, icon: Icon(Icons.delete));
    } else {
      return IconButton(onPressed: () {}, icon: Icon(Icons.info_outline));
    }
  }
  return IconButton(onPressed: () {}, icon: Icon(Icons.info_outline));
}
