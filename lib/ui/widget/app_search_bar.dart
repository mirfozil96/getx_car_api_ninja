import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../generated/assets.dart';
import '../utils/app_color.dart';

class AppAnimationSearchBar extends StatefulWidget {
  const AppAnimationSearchBar({
    super.key,
    this.searchBarWidth,
    this.searchBarHeight,
    this.previousScreen,
    this.backIconColor,
    this.closeIconColor,
    this.searchIconColor,
    this.title,
    this.titleStyle,
    this.searchFieldHeight,
    this.searchFieldDecoration,
    this.cursorColor,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    required this.onChanged,
    required this.searchTextEditingController,
    this.horizontalPadding,
    this.verticalPadding,
    this.isBackButtonVisible,
    this.backIcon,
    this.duration,
    this.backgroundColor,
    this.actions = const [],
    this.onSearchFocused,
  });

  ///
  final double? searchBarWidth;
  final double? searchBarHeight;
  final double? searchFieldHeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget? previousScreen;
  final Color? backIconColor;
  final Color? closeIconColor;
  final Color? searchIconColor;
  final Color? cursorColor;
  final Color? backgroundColor;
  final String? title;
  final String? hintText;
  final bool? isBackButtonVisible;
  final IconData? backIcon;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Decoration? searchFieldDecoration;
  final Duration? duration;
  final TextEditingController searchTextEditingController;
  final Function(String) onChanged;
  final List<Widget> actions;
  final VoidCallback? onSearchFocused;

  @override
  State<AppAnimationSearchBar> createState() => _AppAnimationSearchBarState();
}

class _AppAnimationSearchBarState extends State<AppAnimationSearchBar> {
  bool _isSearching = false;

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColor.primary60, width: 2),
      borderRadius: BorderRadius.circular(244),
    );
  }

  @override
  Widget build(BuildContext context) {
    final duration = widget.duration ?? const Duration(milliseconds: 500);
    final searchFieldHeight = widget.searchFieldHeight ?? 40;
    final hPadding =
        widget.horizontalPadding != null ? widget.horizontalPadding! * 2 : 0;
    final searchBarWidth =
        widget.searchBarWidth ?? MediaQuery.of(context).size.width - hPadding;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding ?? 0,
          vertical: widget.verticalPadding ?? 0),
      child: Container(
        color: widget.backgroundColor ?? Colors.white,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: searchBarWidth,
            height: widget.searchBarHeight ?? 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // back Button
                AnimatedContainer(
                  curve: Curves.easeInOutCirc,
                  width: 35,
                  height: 35,
                  duration: duration,
                  child: KBackButton(
                    icon: widget.backIcon,
                    iconColor: widget.backIconColor,
                    previousScreen: widget.previousScreen,
                  ),
                ),

                // /// text
                AnimatedOpacity(
                  opacity: _isSearching ? 0 : 1,
                  duration: duration,
                  child: AnimatedContainer(
                    margin:
                        _isSearching ? null : const EdgeInsets.only(left: 10),
                    curve: Curves.easeInOutCirc,
                    duration: duration,
                    alignment: Alignment.center,
                    width: _isSearching ? 0 : null,
                    child: Text(
                      widget.title ?? 'title'.tr,
                      textAlign: TextAlign.start,
                      style: widget.titleStyle ??
                          const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                    ),
                  ),
                ),

                /// close search
                // AnimatedOpacity(
                //   opacity: _isSearching ? 1 : 0,
                //   duration: _duration,
                //   child: AnimatedContainer(
                //     curve: Curves.easeInOutCirc,
                //     width: _isSearching ? 35 : 0,
                //     height: _isSearching ? 35 : 0,
                //     duration: _duration,
                //     child: FittedBox(
                //       child: KCustomButton(
                //         widget: Padding(
                //             padding: const EdgeInsets.all(3),
                //             child: Icon(Icons.close,
                //                 color: widget.closeIconColor ??
                //                     Colors.black.withOpacity(.7))),
                //         onPressed: () {
                //           setState(() {
                //             _isSearching = false;
                //           });
                //           widget.searchTextEditingController.clear();
                //         },
                //       ),
                //     ),
                //   ),
                // ),

                const Spacer(),

                /// input panel
                AnimatedOpacity(
                  opacity: _isSearching ? 1 : 0,
                  duration: 300.milliseconds,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCirc,
                    duration: 300.milliseconds,
                    width: _isSearching
                        ? searchBarWidth -
                            46 -
                            (widget.horizontalPadding ?? 0 * 2)
                        : 0,
                    height: _isSearching ? searchFieldHeight : 20,
                    margin: EdgeInsets.only(
                      left: _isSearching ? 5 : 0,
                      right: _isSearching ? 10 : 0,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: widget.searchTextEditingController,
                      cursorColor: widget.cursorColor ?? AppColor.basic25,
                      style: widget.textStyle ??
                          const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 8),
                          child: SvgPicture.asset(
                            Assets.iconsIcSearch,
                            color: AppColor.basic50,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 30,
                          maxWidth: 40,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearching = false;
                              widget.searchTextEditingController.clear();
                              widget.onChanged('');
                              FocusManager.instance.primaryFocus?.unfocus();
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8, right: 10),
                            child: Icon(Icons.clear),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 30,
                          maxWidth: 40,
                        ),
                        filled: true,
                        fillColor: AppColor.basic95,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
                        hintText: widget.hintText ?? 'search_here'.tr,
                        hintStyle: widget.hintStyle ??
                            const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                        focusedBorder: _border(),
                        enabledBorder: _border(),
                        border: _border(),
                        disabledBorder: _border(),
                        errorBorder: _border(),
                        focusedErrorBorder: _border(),
                      ),
                      onChanged: widget.onChanged,
                    ),
                  ),
                ),

                ///  search button
                AnimatedOpacity(
                  opacity: _isSearching ? 0 : 1,
                  duration: duration,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCirc,
                    duration: duration,
                    width: _isSearching ? 0 : null,
                    height: _isSearching ? 0 : null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FittedBox(
                          child: KCustomButton(
                            widget: Padding(
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset(Assets.iconsIcSearch,
                                    color: widget.searchIconColor)),
                            onPressed: () => setState(
                              () {
                                _isSearching = true;
                                widget.onSearchFocused?.call();
                              },
                            ),
                          ),
                        ),
                        ...widget.actions
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KCustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? radius;

  const KCustomButton(
      {super.key,
      required this.widget,
      required this.onPressed,
      this.radius,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 50),
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(radius ?? 50),
            child: InkWell(
                splashColor: Theme.of(context).primaryColor.withOpacity(.2),
                highlightColor: Theme.of(context).primaryColor.withOpacity(.05),
                onTap: onPressed,
                onLongPress: onLongPress,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: widget))));
  }
}

class KBackButton extends StatelessWidget {
  final Widget? previousScreen;
  final Color? iconColor;
  final IconData? icon;

  const KBackButton(
      {super.key,
      required this.previousScreen,
      required this.iconColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
                splashColor: Theme.of(context).primaryColor.withOpacity(.2),
                highlightColor: Theme.of(context).primaryColor.withOpacity(.05),
                onTap: () async {
                  previousScreen == null
                      ? Navigator.pop(context)
                      : Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => previousScreen!));
                },
                child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(icon ?? Icons.arrow_back,
                            color: iconColor ?? Colors.black.withOpacity(.7),
                            size: 25))))));
  }
}
