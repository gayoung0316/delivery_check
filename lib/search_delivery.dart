import 'package:delivery_project/delivery_state_list.dart';
import 'package:delivery_project/model/delivery_list.dart';
import 'package:delivery_project/provider/delivery_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'components/custom_dropdown.dart';

class SearchDelivery extends StatefulWidget {
  const SearchDelivery({Key? key}) : super(key: key);

  @override
  _SearchDeliveryState createState() => _SearchDeliveryState();
}

class _SearchDeliveryState extends State<SearchDelivery> {
  Dio dio = Dio();
  String _carrierId = '';
  final TextEditingController _textEditingController = TextEditingController();

  DeliveryProvider? deliveryProvider;

  @override
  Widget build(BuildContext context) {
    deliveryProvider = Provider.of<DeliveryProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF8F8FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 335.w,
              height: 52.w,
              margin: EdgeInsets.only(top: 70.w, left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.w),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3fc9c8ce),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CustomDropdown<int>(
                    onChange: (int value, int index, String carrierId) {
                      setState(() {
                        _carrierId = carrierId;
                      });
                    },
                    dropdownButtonStyle: DropdownButtonStyle(
                      height: 52.w,
                    ),
                    dropdownStyle: DropdownStyle(
                      borderRadius: BorderRadius.circular(16.w),
                      width: 200.w,
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 60.w),
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text(
                        '택배사',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xff1B1B1D),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    items: deliveryList.asMap().entries.map(
                      (item) {
                        return DropdownItem<int>(
                          value: item.key + 1,
                          text: item.value['name'],
                          carrierId: item.value['id'],
                          child: Text(
                            item.value['name']!,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: const Color(0xff1B1B1D),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: TextField(
                      onSubmitted: (value) {
                        deliveryProvider?.getDeliveryList(
                          carrierId: _carrierId,
                          trackId: value,
                        );
                      },
                      controller: _textEditingController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      cursorColor: const Color(0xff1B1B1D),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: '운송장 번호 - 없이 입력',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          letterSpacing: -0.25.w,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffC8C8CB),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff1B1B1D),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      deliveryProvider?.getDeliveryList(
                        carrierId: _carrierId,
                        trackId: _textEditingController.value.text,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Image.asset(
                        'assets/serach.png',
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                  )
                ],
              ),
            ),
            deliveryProvider!.delivery != null
                ? const DeliveryStateList()
                : Container(),
          ],
        ),
      ),
    );
  }
}
