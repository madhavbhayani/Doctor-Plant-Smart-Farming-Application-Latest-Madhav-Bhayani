import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewDailyMarketPricesDetailScreen extends StatefulWidget {
  final Map<String, dynamic> _commodity;

  const NewDailyMarketPricesDetailScreen(this._commodity, {super.key});

  @override
  State<NewDailyMarketPricesDetailScreen> createState() =>
      _NewDailyMarketPricesDetailScreenState();
}

class _NewDailyMarketPricesDetailScreenState
    extends State<NewDailyMarketPricesDetailScreen> {
  get data => widget._commodity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: CircularIconButton(
              iconData: Icons.close,
              onPressed: () {
                Navigator.pop(context);
              },
              iconColor: Colors.grey[800],
            ),
            actions: [
              CircularIconButton(
                iconData: Icons.ios_share,
                iconSize: 20,
                onPressed: () {},
                iconColor: Colors.grey[800],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              // background: PageViewWithIndicators(
              //   children: [
              //     Image.network(
              //       'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              //       fit: BoxFit.cover,
              //     ),
              //     Image.network(
              //       'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              //       fit: BoxFit.cover,
              //     ),
              //     Image.network(
              //       'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              //       fit: BoxFit.cover,
              //     ),
              //   ],
              //   type: IndicatorType.numbered,
              // ),

              background: Image.network(
                filterQuality: FilterQuality.high,
                _imagefetcher(data['commodity']),
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: 280,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          '${data['commodity']}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Market : ${data['market']}",
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "District : ${data['district']}",
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "State : ${data['state']}",
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const MyDivider(),
                      Column(
                        children: [
                          SizedBox(
                            height: 4.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Market Pricing",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Arrival Date : ${data['arrival_date']}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                            child: GridView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.5, crossAxisCount: 2),
                              children: [
                                Card(
                                  elevation: 4,
                                  color: const Color(0xffB2E7B6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${data['min_price']}₹',
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      const Text(
                                        'Minimum Price',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      const Text(
                                        '(Per 100kg)',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  elevation: 4,
                                  color: const Color(0xffB2E7B6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${data['max_price']}₹',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Text(
                                        'Maximum Price',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Text(
                                        '(Per 100kg)',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  elevation: 4,

                                  // color: const Color(0xffB2E7B6),
                                  color: const Color(0xffB2E7B6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${data['modal_price']}₹',
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Text(
                                        'Modal Price',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const Text(
                                        '(Per 100kg)',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  elevation: 4,
                                  color: const Color(0xffB2E7B6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          '${data['variety']}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const Text(
                                        'Variety/Category',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const MyDivider(),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          child: Text(
                            'See more on ${data['commodity']} in ${data['state']}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Doctor Plant',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Daily Market Pricing Module',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.1.h),
                      const Text(
                        'Doctor Plant is a platform that provides you with the latest market prices of various commodities in different markets. We aim to provide you with the most accurate and up-to-date information on the prices of various commodities in different markets. Our platform is designed to help you make informed decisions about your purchases and sales. We hope that you find our platform useful and that it helps you make better decisions about your business.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const MyDivider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 48,
      thickness: 1,
    );
  }
}

const String loremIpsumText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nulla dolor, fermentum nec rhoncus vitae, vehicula quis ipsum. Mauris dapibus velit in quam scelerisque gravida. Etiam luctus augue ut lacus iaculis vehicula. In vel pretium arcu. Fusce fringilla volutpat hendrerit. Morbi nec accumsan nunc. Integer at iaculis justo. Ut dignissim scelerisque mi vitae consectetur. Mauris tincidunt erat at mi feugiat, id gravida justo suscipit. Vestibulum non ipsum varius, sagittis est vitae, ultrices est. Donec semper ligula vel urna ultricies varius. Aenean lacinia risus ut aliquam bibendum. Nullam justo ex, auctor ultricies eros a, commodo dapibus massa. Etiam tristique semper tempus. Vivamus elementum nisl neque, eu eleifend metus lobortis sed.';

/// Consistent padding for horizontal sides of screen. Most commonly used in ListViews to give content padding but still allow items to scroll off the screen.
const double kHorizontalPadding = 16;

/// Consistent padding for vertical sides of screen.
const double kVerticalPadding = 64;

class CircularIconButton extends StatelessWidget {
  const CircularIconButton(
      {this.iconData,
      this.onPressed,
      this.iconColor = Colors.black,
      this.backgroundColor = Colors.white,
      this.iconSize = 24,
      this.radius = 36,
      super.key});
  final IconData? iconData;
  final Function? onPressed;
  // Defaults to 36. This value should be larger than [iconSize]
  final double radius;
  // Defaults to 24. This value should be smaller than [radius]
  final double iconSize;
  final Color? iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed as void Function()?,
      color: iconColor,
      padding: EdgeInsets.zero,
      splashRadius: 24,
      iconSize: iconSize,
      icon: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(
          iconData,
        ),
      ),
    );
  }
}

enum IndicatorType { dots, numbered }

class PageViewWithIndicators extends StatefulWidget {
  const PageViewWithIndicators(
      {required this.children, this.type = IndicatorType.dots, Key? key})
      : super(key: key);
  final List<Widget> children;
  final IndicatorType type;

  @override
  State<PageViewWithIndicators> createState() => _PageViewWithIndicatorsState();
}

class _PageViewWithIndicatorsState extends State<PageViewWithIndicators> {
  late int activeIndex;

  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }

  setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  _buildDottedIndicators() {
    List<Widget> dots = [];
    const double radius = 8;

    for (int i = 0; i < widget.children.length; i++) {
      dots.add(
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                i == activeIndex ? Colors.white : Colors.white.withOpacity(.6),
          ),
        ),
      );
    }
    dots = intersperse(const SizedBox(width: 6), dots)
        .toList(); // Add spacing between dots

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots,
        ),
      ),
    );
  }

  _buildNumberedIndicators() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.33),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Text(
            '${(activeIndex + 1).toString()} / ${widget.children.length.toString()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: setActiveIndex,
          children: widget.children,
        ),
        widget.type == IndicatorType.dots
            ? _buildDottedIndicators()
            : _buildNumberedIndicators(),
      ],
    );
  }
}

Iterable<T> intersperse<T>(T element, Iterable<T> iterable) sync* {
  final iterator = iterable.iterator;
  if (iterator.moveNext()) {
    yield iterator.current;
    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}

_imagefetcher(original_commodity_name) {
  //paging concept
  // print(original_commodity_name);
  if (original_commodity_name == 'Apple') {
    return 'URL';
  } else if (original_commodity_name == 'Ajwan') {
    return 'URL';
  }
  // Write the code to fetch the image from the internet based on the commodity name and return the URL of the image here as a string value in the return statement below this comment line
}
