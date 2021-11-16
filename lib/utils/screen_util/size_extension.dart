part of flutter_screenutil;

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  double get w {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().setWidth(this);
  }

  ///[ScreenUtil.setHeight]
  double get h {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().setHeight(this);
  }

  ///[ScreenUtil.radius]
  double get r {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().radius(this);
  }

  ///[ScreenUtil.setSp]
  double get sp {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().setSp(this);
  }

  ///[ScreenUtil.setSp]
  @Deprecated('please use [sp]')
  double get ssp {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().setSp(this);
  }

  ///[ScreenUtil.setSp]
  @Deprecated('please use [sp] , and set textScaleFactor: 1.0 , for example: Text("text", textScaleFactor: 1.0)')
  double get nsp {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().setSp(this);
  }

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get sw {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().screenWidth * this;
  }

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get sh {
    if (kIsWeb) return this.toDouble();
    return ScreenUtil().screenHeight * this;
  }
}
