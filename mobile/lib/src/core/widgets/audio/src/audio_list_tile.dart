import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';
import 'package:provider/provider.dart';

// typedef OnTap = void Function(AudioObject audioObject);

class AudioObject {
  final String audio;
  final String? image;
  final LocalizedEntity? title, subtitle;

  // final LocalizedEntity? name, bio;

  const AudioObject({
    required this.audio,
    this.image,
    this.title,
    this.subtitle,
  });

  @override
  String toString() {
    return 'title is $title, subtitle is $subtitle, image is $image';
  }
}

class AudioListTile extends StatelessWidget {
  final ReciterEntity reciter;
  final void Function() onTap;

  const AudioListTile({
    super.key,
    required this.reciter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AppImageWidget(
          path: reciter.image,
          width: 52,
          height: 52,
          boxFit: BoxFit.cover,
        ),
      ),
      title: Text(
        reciter.name?.en ?? '',
        style: appTextStyle.bold18.copyWith(
          color: themeStore.appColors.textColor,
        ),
      ),
      subtitle: Text(
        reciter.bio?.en ?? '',
        style: appTextStyle.regular14.copyWith(
          color: themeStore.appColors.textColor,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      // trailing: IconButton(
      //   icon: Icon(Icons.play_arrow_outlined),
      //   onPressed: () => onTap(),
      // ),
    );
  }
}
