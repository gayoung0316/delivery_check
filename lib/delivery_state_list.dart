import 'package:delivery_project/provider/delivery_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryStateList extends StatefulWidget {
  const DeliveryStateList({Key? key}) : super(key: key);

  @override
  _DeliveryStateListState createState() => _DeliveryStateListState();
}

class _DeliveryStateListState extends State<DeliveryStateList> {
  DeliveryProvider? deliveryProvider;

  @override
  Widget build(BuildContext context) {
    deliveryProvider = Provider.of<DeliveryProvider>(context);

    return deliveryProvider!.deliveryLoading
        ? const Center(
            child: Text('로딩 중'),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                  top: 40.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    deliveryIcon(
                      iconIdx: 0,
                      state: deliveryProvider!.delivery!.state.id == 'at_pickup'
                          ? 'on'
                          : 'off',
                    ),
                    deliveryIcon(
                      iconIdx: 1,
                      state:
                          deliveryProvider!.delivery!.state.id == 'in_transit'
                              ? 'on'
                              : 'off',
                    ),
                    deliveryIcon(
                      iconIdx: 2,
                      state: deliveryProvider!.delivery!.state.id ==
                              'out_for_delivery'
                          ? 'on'
                          : 'off',
                    ),
                    deliveryIcon(
                      iconIdx: 3,
                      state: deliveryProvider!.delivery!.state.id == 'delivered'
                          ? 'on'
                          : 'off',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Text(
                  deliveryProvider!.delivery!.state.id == 'at_pickup'
                      ? '📦 택배를 인수하고 있어요 📦'
                      : deliveryProvider!.delivery!.state.id == 'in_transit'
                          ? '🚚 택배가 이동 중이에요 🚚 '
                          : deliveryProvider!.delivery!.state.id ==
                                  'out_for_delivery'
                              ? '🚚 택배가 배달 중이에요 🚚 '
                              : deliveryProvider!.delivery!.state.id ==
                                      'delivered'
                                  ? '😄 택배 배송을 완료 했어요 😄'
                                  : '',
                  style: TextStyle(
                    color: const Color(0xff1B1B1D),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 14.w),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3fc9c8ce),
                      blurRadius: 20,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 18.w,
                        bottom: 12.w,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '배송시간',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xffC8C7CB),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '현재위치',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xffC8C7CB),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '배송상태',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xffC8C7CB),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                      color: Color(0xffF8F8FB),
                    ),
                    SizedBox(height: 8.w),
                    ...deliveryProvider!.delivery!.progresses.map((item) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.time
                                        .toString()
                                        .split('.')[0]
                                        .split(':00')[0],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xff1B1B1D),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item.location.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xff1B1B1D),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item.status.text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xff1B1B1D),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          deliveryProvider!.delivery!.progresses.indexOf(item) +
                                      1 !=
                                  deliveryProvider!.delivery!.progresses.length
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.w),
                                  child: const Divider(
                                    thickness: 1,
                                    height: 0,
                                    color: Color(0xffF8F8FB),
                                  ),
                                )
                              : SizedBox(height: 16.w),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
  }

  Widget deliveryIcon({int? iconIdx, String? state}) {
    return Image.asset(
      'assets/delivery_icon_${iconIdx}_$state.png',
      width: 54.w,
      height: 54.w,
    );
  }
}
