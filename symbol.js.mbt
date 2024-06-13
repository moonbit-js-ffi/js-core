type JsSymbol JsValue

pub fn FromJsValue::from_js_value(value : JsValue) -> JsSymbol {
  JsSymbol(value)
}

pub fn ToJsValue::to_js_value(arr : JsSymbol) -> JsValue {
  arr.0
}

pub extern "js" fn JsSymbol::make_ffi(value : JsValue) -> JsValue =
  #|(descriptor) => Symbol(descriptor)

pub fn JsSymbol::make() -> JsSymbol {
  JsSymbol::make_ffi(JsValue::undefined()) |> from_js_value
}

pub fn JsSymbol::make_with_string_js(value : JsString) -> JsSymbol {
  JsSymbol::make_ffi(value |> to_js_value) |> from_js_value
}

pub fn JsSymbol::make_with_string(value : String) -> JsSymbol {
  JsSymbol::make_with_string_js(JsString::from_string(value))
}

pub fn JsSymbol::make_with_number(value : Double) -> JsSymbol {
  JsSymbol::make_ffi(value |> to_js_value) |> from_js_value
}
