// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final double? size;
  final Color? color;
  final String? message;
  final bool showMessage;
  final LoadingType type;
  final double strokeWidth;

  const LoadingIndicator({
    super.key,
    this.size,
    this.color,
    this.message,
    this.showMessage = false,
    this.type = LoadingType.circular,
    this.strokeWidth = 3.0,
  });

  // Factory constructors for common use cases
  const LoadingIndicator.overlay({
    super.key,
    this.message = 'Loading...',
    this.size = 40,
    this.color,
    this.strokeWidth = 3.0,
  }) : showMessage = true,
       type = LoadingType.overlay;

  const LoadingIndicator.small({
    super.key,
    this.size = 20,
    this.color,
    this.strokeWidth = 2.0,
  }) : showMessage = false,
       message = null,
       type = LoadingType.circular;

  const LoadingIndicator.large({
    super.key,
    this.size = 60,
    this.color,
    this.message = 'Please wait...',
    this.strokeWidth = 4.0,
  }) : showMessage = true,
       type = LoadingType.circular;

  const LoadingIndicator.dots({
    super.key,
    this.size = 40,
    this.color,
    this.message,
    this.showMessage = false,
    this.strokeWidth = 3.0,
  }) : type = LoadingType.dots;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = widget.color ?? theme.primaryColor;

    switch (widget.type) {
      case LoadingType.overlay:
        return _buildOverlayLoading(effectiveColor);
      case LoadingType.dots:
        return _buildDotsLoading(effectiveColor);
      case LoadingType.circular:
        return _buildCircularLoading(effectiveColor);
    }
  }

  Widget _buildOverlayLoading(Color color) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widget.size ?? 40,
                height: widget.size ?? 40,
                child: CircularProgressIndicator(
                  strokeWidth: widget.strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              if (widget.showMessage && widget.message != null) ...[
                const SizedBox(height: 16),
                Text(
                  widget.message!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularLoading(Color color) {
    final loading = SizedBox(
      width: widget.size ?? 40,
      height: widget.size ?? 40,
      child: CircularProgressIndicator(
        strokeWidth: widget.strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );

    if (widget.showMessage && widget.message != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loading,
          const SizedBox(height: 12),
          Text(
            widget.message!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return loading;
  }

  Widget _buildDotsLoading(Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _dotsController,
          builder: (context, child) {
            final animationValue =
                (_dotsController.value - (index * 0.2)) % 1.0;
            final scale = animationValue < 0.5
                ? 1.0 + (animationValue * 0.5)
                : 1.5 - ((animationValue - 0.5) * 0.5);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.7 + (scale - 1.0) * 0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

enum LoadingType { circular, overlay, dots }

extension LoadingIndicatorExtension on Widget {
  Widget withLoading({bool isLoading = false, String? message, Color? color}) {
    return Stack(
      children: [
        this,
        if (isLoading)
          Positioned.fill(
            child: LoadingIndicator.overlay(message: message, color: color),
          ),
      ],
    );
  }
}
