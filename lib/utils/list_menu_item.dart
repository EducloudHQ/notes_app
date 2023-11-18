import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_ai/screens/model/menu_model.dart';
class ListMenuItem extends StatelessWidget {
 ListMenuItem({required this.menuItem,required this.animationController,
   required this.animation,
   required  this.callback});

  final MenuModel menuItem;
 final VoidCallback? callback;
 final AnimationController? animationController;
 final Animation<double>? animation;
  @override
  Widget build(BuildContext context) {
    return  AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation!.value), 0.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.0, color: Colors.white.withOpacity(0.4))

                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(menuItem.icon, height: 20,
                        width: 20,
                        color: menuItem.color,),
                      Container(
                        padding: const EdgeInsets.only(left: 10),

                        child: Text(
                          menuItem.title, style: const TextStyle(color: Colors
                            .white),),

                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
