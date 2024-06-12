type JsString JsValue

pub fn ToJsValue::to_js_value(self : JsString) -> JsValue {
  self.0
}

pub fn FromJsValue::from_js_value(self : JsValue) -> JsString {
  JsString(self)
}

pub extern "js" fn JsString::empty_ffi() -> JsValue =
  #|() => ""

pub fn JsString::empty() -> JsString {
  JsString(JsString::empty_ffi())
}

pub fn JsString::length(self : JsString) -> Int {
  self |> to_js_value |> length_ffi
}

pub extern "js" fn JsString::from_code_point_ffi(value : JsValue) -> JsValue =
  #|(codePoints) => String.fromCodePoint(...codePoints)

pub extern "js" fn JsString::to_code_point_ffi(value : JsValue) -> JsValue =
  #|(str) => [...str].map(c => c.codePointAt(0))

pub fn JsString::from_code_point_js(value : JsArray[Int]) -> JsString {
  JsString::from_code_point_ffi(value |> to_js_value) |> from_js_value
}

pub fn JsString::to_code_point_js(value : JsString) -> JsArray[Int] {
  JsString::to_code_point_ffi(value |> to_js_value) |> from_js_value
}

pub fn JsString::from_string(str : String) -> JsString {
  str.as_iter().map(Char::to_int).fold(
    fn(array : JsArray[Int], ch : Int) {
      array.push(ch)
      array
    },
    JsArray::new(),
  )
  |> JsString::from_code_point_js
}

pub fn JsString::to_string(str : JsString) -> String {
  str.to_code_point_js().to_array().as_iter().fold(
    fn(buffer : Buffer, ch : Int) {
      buffer.write_char(Char::from_int(ch))
      buffer
    },
    Buffer::make(100),
  ).to_string()
}
