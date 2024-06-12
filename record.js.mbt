type Record JsValue

pub extern "js" fn Record::get_ffi(self : JsValue, key : JsValue) -> JsValue =
  #|(object, key) => object[key]

pub fn Record::get_js(self : Record, key : JsString) -> JsValue {
  Record::get_ffi(self |> to_js_value, key |> to_js_value) |> from_js_value
}

pub fn get(self : Record, key : String) -> JsValue {
  self.get_js(JsString::from_string(key))
}

pub fn FromJsValue::from_js_value(value : JsValue) -> Record {
  Record(value)
}

pub fn ToJsValue::to_js_value(value : Record) -> JsValue {
  value.0
}
