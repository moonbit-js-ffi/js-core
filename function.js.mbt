type JsFunction JsValue

pub fn ToJsValue::to_js_value(self : JsFunction) -> JsValue {
  self.0
}

pub fn FromJsValue::from_js_value(self : JsValue) -> JsFunction {
  JsFunction(self)
}

pub extern "js" fn new_function_ffi(func : (JsValue) -> JsValue) -> JsValue =
  #|(func) => func

pub extern "js" fn new_function_empty_ffi() -> JsValue =
  #|() => {}

pub fn JsFunction::new[T : FromJsValue, R : ToJsValue](
  func : (T) -> R
) -> JsValue {
  new_function_ffi(fn { p => func(p |> from_js_value) |> to_js_value })
}

pub fn JsFunction::noop() -> JsValue {
  new_function_empty_ffi()
}
