type JS_Symbol JsValue

pub fn FromJsValue::from_js_value(value : JsValue) -> JS_Symbol {
  JS_Symbol(value)
}

pub fn ToJsValue::to_js_value(arr : JS_Symbol) -> JsValue {
  arr.0
}

pub extern "js" fn JS_Symbol::make_ffi(value : JsValue) -> JsValue =
  #|(descriptor) => Symbol(descriptor)

pub fn JS_Symbol::make() -> JS_Symbol {
  JS_Symbol::make_ffi(JsValue::undefined()) |> from_js_value
}

pub fn JS_Symbol::make_with_string_js(value : JsString) -> JS_Symbol {
  JS_Symbol::make_ffi(value |> to_js_value) |> from_js_value
}

pub fn JS_Symbol::make_with_string(value : String) -> JS_Symbol {
  JS_Symbol::make_with_string_js(JsString::from_string(value))
}

pub fn JS_Symbol::make_with_number(value : Double) -> JS_Symbol {
  JS_Symbol::make_ffi(value |> to_js_value) |> from_js_value
}
