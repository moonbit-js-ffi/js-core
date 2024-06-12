type DataView JsValue

pub fn FromJsValue::from_js_value(value : JsValue) -> DataView {
  DataView(value)
}

pub fn ToJsValue::to_js_value(value : DataView) -> JsValue {
  value.0
}

pub extern "js" fn data_view_new_ffi(
  buffer : JsValue,
  byte_offset : Int,
  byte_length : Int
) -> JsValue =
  #|(buffer, byte_offset, byte_length) => new DataView(buffer, byte_offset, byte_length)

pub extern "js" fn data_view_get_int8_ffi(
  data_view : JsValue,
  byte_offset : Int
) -> Int =
  #|(data_view, byte_offset) => data_view.getInt8(byte_offset)

pub extern "js" fn data_view_get_uint8_ffi(
  data_view : JsValue,
  byte_offset : Int
) -> Int =
  #|(data_view, byte_offset) => data_view.getUint8(byte_offset)

pub extern "js" fn data_view_get_int16_ffi(
  data_view : JsValue,
  byte_offset : Int,
  little_endian : Bool
) -> Int =
  #|(data_view, byte_offset, little_endian) => data_view.getInt16(byte_offset, little_endian)

pub extern "js" fn data_view_get_uint16_ffi(
  data_view : JsValue,
  byte_offset : Int,
  little_endian : Bool
) -> Int =
  #|(data_view, byte_offset, little_endian) => data_view.getUint16(byte_offset, little_endian)

pub extern "js" fn data_view_get_int32_ffi(
  data_view : JsValue,
  byte_offset : Int,
  little_endian : Bool
) -> Int =
  #|(data_view, byte_offset, little_endian) => data_view.getInt32(byte_offset, little_endian)

pub extern "js" fn data_view_get_uint32_ffi(
  data_view : JsValue,
  byte_offset : Int,
  little_endian : Bool
) -> Int =
  #|(data_view, byte_offset, little_endian) => data_view.getUint32(byte_offset, little_endian)

pub extern "js" fn data_view_get_float32_ffi(
  data_view : JsValue,
  byte_offset : Int,
  little_endian : Bool
) -> Double =
  #|(data_view, byte_offset, little_endian) => data_view.getFloat32(byte_offset, little_endian)

pub extern "js" fn data_view_get_float64_ffi(
  data_view : JsValue,
  byte_offset : Int,
  little_endian : Bool
) -> Double =
  #|(data_view, byte_offset, little_endian) => data_view.getFloat64(byte_offset, little_endian)

pub extern "js" fn data_view_set_int8_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Int
) -> Unit =
  #|(data_view, byte_offset, value) => data_view.setInt8(byte_offset, value)

pub extern "js" fn data_view_set_uint8_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Int
) -> Unit =
  #|(data_view, byte_offset, value) => data_view.setUint8(byte_offset, value)

pub extern "js" fn data_view_set_int16_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit =
  #|(data_view, byte_offset, value, little_endian) => data_view.setInt16(byte_offset, value, little_endian)

pub extern "js" fn data_view_set_uint16_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit =
  #|(data_view, byte_offset, value, little_endian) => data_view.setUint16(byte_offset, value, little_endian)

pub extern "js" fn data_view_set_int32_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit =
  #|(data_view, byte_offset, value, little_endian) => data_view.setInt32(byte_offset, value, little_endian)

pub extern "js" fn data_view_set_uint32_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit =
  #|(data_view, byte_offset, value, little_endian) => data_view.setUint32(byte_offset, value, little_endian)

pub extern "js" fn data_view_set_float32_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Double,
  little_endian : Bool
) -> Unit =
  #|(data_view, byte_offset, value, little_endian) => data_view.setFloat32(byte_offset, value, little_endian)

pub extern "js" fn data_view_set_float64_ffi(
  data_view : JsValue,
  byte_offset : Int,
  value : Double,
  little_endian : Bool
) -> Unit =
  #|(data_view, byte_offset, value, little_endian) => data_view.setFloat64(byte_offset, value, little_endian)

pub fn DataView::new(
  buffer : ArrayBuffer,
  byte_offset : Int,
  byte_length : Int
) -> DataView {
  data_view_new_ffi(buffer |> to_js_value, byte_offset, byte_length)
  |> from_js_value
}

pub fn DataView::get_int8(self : DataView, byte_offset : Int) -> Int {
  data_view_get_int8_ffi(self |> to_js_value, byte_offset)
}

pub fn DataView::get_uint8(self : DataView, byte_offset : Int) -> Int {
  data_view_get_uint8_ffi(self |> to_js_value, byte_offset)
}

pub fn DataView::get_int16(
  self : DataView,
  byte_offset : Int,
  little_endian : Bool
) -> Int {
  data_view_get_int16_ffi(self |> to_js_value, byte_offset, little_endian)
}

pub fn DataView::get_uint16(
  self : DataView,
  byte_offset : Int,
  little_endian : Bool
) -> Int {
  data_view_get_uint16_ffi(self |> to_js_value, byte_offset, little_endian)
}

pub fn DataView::get_int32(
  self : DataView,
  byte_offset : Int,
  little_endian : Bool
) -> Int {
  data_view_get_int32_ffi(self |> to_js_value, byte_offset, little_endian)
}

pub fn DataView::get_uint32(
  self : DataView,
  byte_offset : Int,
  little_endian : Bool
) -> Int {
  data_view_get_uint32_ffi(self |> to_js_value, byte_offset, little_endian)
}

pub fn DataView::get_float32(
  self : DataView,
  byte_offset : Int,
  little_endian : Bool
) -> Double {
  data_view_get_float32_ffi(self |> to_js_value, byte_offset, little_endian)
}

pub fn DataView::get_float64(
  self : DataView,
  byte_offset : Int,
  little_endian : Bool
) -> Double {
  data_view_get_float64_ffi(self |> to_js_value, byte_offset, little_endian)
}

pub fn DataView::set_int8(
  self : DataView,
  byte_offset : Int,
  value : Int
) -> Unit {
  data_view_set_int8_ffi(self |> to_js_value, byte_offset, value)
}

pub fn DataView::set_uint8(
  self : DataView,
  byte_offset : Int,
  value : Int
) -> Unit {
  data_view_set_uint8_ffi(self |> to_js_value, byte_offset, value)
}

pub fn DataView::set_int16(
  self : DataView,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit {
  data_view_set_int16_ffi(
    self |> to_js_value,
    byte_offset,
    value,
    little_endian,
  )
}

pub fn DataView::set_uint16(
  self : DataView,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit {
  data_view_set_uint16_ffi(
    self |> to_js_value,
    byte_offset,
    value,
    little_endian,
  )
}

pub fn DataView::set_int32(
  self : DataView,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit {
  data_view_set_int32_ffi(
    self |> to_js_value,
    byte_offset,
    value,
    little_endian,
  )
}

pub fn DataView::set_uint32(
  self : DataView,
  byte_offset : Int,
  value : Int,
  little_endian : Bool
) -> Unit {
  data_view_set_uint32_ffi(
    self |> to_js_value,
    byte_offset,
    value,
    little_endian,
  )
}

pub fn DataView::set_float32(
  self : DataView,
  byte_offset : Int,
  value : Double,
  little_endian : Bool
) -> Unit {
  data_view_set_float32_ffi(
    self |> to_js_value,
    byte_offset,
    value,
    little_endian,
  )
}

pub fn DataView::set_float64(
  self : DataView,
  byte_offset : Int,
  value : Double,
  little_endian : Bool
) -> Unit {
  data_view_set_float64_ffi(
    self |> to_js_value,
    byte_offset,
    value,
    little_endian,
  )
}
