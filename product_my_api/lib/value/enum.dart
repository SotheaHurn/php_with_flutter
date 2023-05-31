enum EnumMenuAddProductProperties {
  addProduct,
  addCategory,
  addBrand,
  addModel,
  supplier,
}

extension EnumMenuAddProductPropertiesPatternMatch
    on EnumMenuAddProductProperties {
  int get value {
    switch (this) {
      case EnumMenuAddProductProperties.addProduct:
        return 1;
      case EnumMenuAddProductProperties.addCategory:
        return 2;
      case EnumMenuAddProductProperties.addBrand:
        return 3;
      case EnumMenuAddProductProperties.addModel:
        return 4;
      case EnumMenuAddProductProperties.supplier:
        return 5;
    }
  }
}
