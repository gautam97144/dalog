part of "widget.dart";

class CustomBottomNavigation extends StatelessWidget {
  CustomBottomNavigation({Key? key}) : super(key: key);

  // ValueNotifier<List<Widget>> list =ValueNotifier([
  //   MyListing(),
  //   const CreatJob(),
  //
  // ]);

  List list = [MyListing(), CreatJob(), MyProfile()];

  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  //int _selecredIndex=0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (BuildContext context, int value, Widget? child) {
        return Scaffold(
          body: list[_selectedIndex.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 5,
                  color: AppColor.grey.withOpacity(.3))
            ]),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex.value,
              onTap: (index) {
                _selectedIndex.value = index;
              },
              items: [
                BottomNavigationBarItem(
                  label: "My Listings".tr(),
                  icon: InkWell(
                    onTap: () {
                      _selectedIndex.value = 0;
                    },
                    child: SvgPicture.asset(
                      AppAsset.list,
                      color: _selectedIndex.value == 0
                          ? AppColor.primaryColor
                          : AppColor.grey,
                      height: Sizes.s24.h,
                      width: Sizes.s24.w,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: plusButton(),
                ),
                BottomNavigationBarItem(
                    label: "profile".tr(),
                    icon: InkWell(
                      onTap: () {
                        _selectedIndex.value = 2;
                      },
                      child: SvgPicture.asset(
                        AppAsset.profile,
                        color: _selectedIndex.value == 2
                            ? AppColor.primaryColor
                            : AppColor.grey,
                        height: Sizes.s24.h,
                        width: Sizes.s24.w,
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget plusButton() {
    return SizedBox(
      // color: Colors.green,
      height: Sizes.s44.h,
      width: Sizes.s70.w,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
              backgroundColor: MaterialStateProperty.all(AppColor.red),
              shadowColor: MaterialStateProperty.all(AppColor.red)),
          onPressed: () {
            _selectedIndex.value = 1;
          },
          child: const Center(
            child: Icon(Icons.add),
          )),
    );
  }
}
