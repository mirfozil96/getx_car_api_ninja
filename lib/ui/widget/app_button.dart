import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../utils/app_typography.dart';
import 'app_loader.dart';

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.prependIcon,
    this.appendIcon,
    this.disabled = false,
    this.loading = false,
  });

  final String text;
  final VoidCallback onTap;
  final String? prependIcon;
  final String? appendIcon;
  final bool disabled;
  final bool loading;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "tag_primary_button",
      child: GestureDetector(
        onTap: () {
          if (!widget.disabled) {
            widget.onTap.call();
          }
        },
        onTapDown: (details) => setState(() {
          if (!widget.disabled) {
            pressed = true;
          }
        }),
        onTapUp: (details) => setState(() {
          if (!widget.disabled) {
            pressed = false;
          }
        }),
        onTapCancel: () => setState(() {
          if (!widget.disabled) {
            pressed = false;
          }
        }),
        child: SizedBox(
          height: 4 + 48,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: 100.milliseconds,
                height: pressed ? 4 : 0,
              ),
              AnimatedOpacity(
                duration: 100.milliseconds,
                opacity: widget.disabled ? .65 : 1,
                child: AnimatedContainer(
                  height: 48,
                  decoration: BoxDecoration(
                      color: widget.disabled
                          ? AppColor.primary70
                          : pressed
                              ? AppColor.primary50
                              : AppColor.primary60,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: pressed
                          ? []
                          : [
                              BoxShadow(
                                color: widget.disabled
                                    ? AppColor.primary60
                                    : AppColor.primary40,
                                offset: const Offset(0, 4),
                              )
                            ]),
                  duration: 100.milliseconds,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: widget.loading
                        ? [
                            const AppLoader(),
                          ]
                        : [
                            if (widget.prependIcon != null) ...{
                              SvgPicture.asset(widget.prependIcon!),
                              const SizedBox(
                                width: 6,
                              ),
                            },
                            Text(
                              widget.text,
                              textAlign: TextAlign.center,
                              style: AppTypography.bodyLargeBold
                                  .copyWith(color: AppColor.white),
                            ),
                            if (widget.appendIcon != null) ...{
                              const SizedBox(
                                width: 6,
                              ),
                              SvgPicture.asset(widget.appendIcon!),
                            },
                          ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppTertiaryButton extends StatefulWidget {
  const AppTertiaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.prependIcon,
    this.appendIcon,
    this.disabled = false,
    this.loading = false,
  });

  final String text;
  final VoidCallback onTap;
  final String? prependIcon;
  final String? appendIcon;
  final bool disabled;
  final bool loading;

  @override
  State<AppTertiaryButton> createState() => _AppTertiaryButtonState();
}

class _AppTertiaryButtonState extends State<AppTertiaryButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "tag_tertiary_button",
      child: GestureDetector(
        onTap: () {
          if (!widget.disabled) {
            widget.onTap.call();
          }
        },
        onTapDown: (details) => setState(() {
          if (!widget.disabled) {
            pressed = true;
          }
        }),
        onTapUp: (details) => setState(() {
          if (!widget.disabled) {
            pressed = false;
          }
        }),
        onTapCancel: () => setState(() {
          if (!widget.disabled) {
            pressed = false;
          }
        }),
        child: AnimatedOpacity(
          duration: 100.milliseconds,
          opacity: widget.disabled ? .64 : 1,
          child: AnimatedContainer(
            height: 48,
            decoration: BoxDecoration(
              color: pressed ? AppColor.primary98 : null,
              borderRadius: BorderRadius.circular(16),
            ),
            duration: 100.milliseconds,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: widget.loading
                  ? [
                      const AppLoader(),
                    ]
                  : [
                      if (widget.prependIcon != null) ...{
                        SvgPicture.asset(
                          widget.prependIcon!,
                          color: AppColor.primary25,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      },
                      Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.primary25,
                        ),
                      ),
                      if (widget.appendIcon != null) ...{
                        const SizedBox(
                          width: 6,
                        ),
                        SvgPicture.asset(
                          widget.appendIcon!,
                          color: AppColor.primary25,
                        ),
                      },
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
