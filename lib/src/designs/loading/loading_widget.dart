part of 'loading.dart';

class TekLoadingWidget extends StatefulWidget {
  const TekLoadingWidget({Key? key}) : super(key: key);

  @override
  State<TekLoadingWidget> createState() => TekLoadingWidgetState();
}

class TekLoadingWidgetState extends State<TekLoadingWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _loadingItem(double opacity) => Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          color: TekColors().primary.withOpacity(opacity),
          shape: BoxShape.circle,
        ),
      );

  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: SizedBox(
            width: 36,
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _loadingItem(0.4),
                    _loadingItem(0.6),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _loadingItem(0.8),
                    _loadingItem(1),
                  ],
                )
              ],
            ),
          ),
        ),
        TekVSpace.p14,
        Text(
          TekLoading().defaultLoadingText,
          style: TekTextStyles.titleMedium.copyWith(
            color: TekColors().primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoading();
  }
}
