type ArrayBuffer JsValue

pub fn FromJsValue::from_js_value(value : JsValue) -> ArrayBuffer {
  ArrayBuffer(value)
}

pub fn ToJsValue::to_js_value(value : ArrayBuffer) -> JsValue {
  value.0
}

pub extern "js" fn array_buffer_new_ffi(byte_length : Int) -> JsValue =
  #|(byte_length) => new ArrayBuffer(byte_length)

pub extern "js" fn array_buffer_slice_ffi(
  buffer : JsValue,
  begin : Int,
  end : Int
) -> JsValue =
  #|(buffer, begin, end) => buffer.slice(begin, end)

pub extern "js" fn array_buffer_byte_length_ffi(buffer : JsValue) -> Int =
  #|(buffer) => buffer.byteLength

pub fn ArrayBuffer::new(byte_length : Int) -> ArrayBuffer {
  array_buffer_new_ffi(byte_length) |> from_js_value
}

pub fn ArrayBuffer::slice(
  self : ArrayBuffer,
  begin : Int,
  end : Int
) -> ArrayBuffer {
  array_buffer_slice_ffi(self |> to_js_value, begin, end) |> from_js_value
}

pub fn ArrayBuffer::byte_length(self : ArrayBuffer) -> Int {
  array_buffer_byte_length_ffi(self |> to_js_value)
}
