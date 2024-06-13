pub type Uint8Array JsValue

pub fn FromJsValue::from_js_value(value : JsValue) -> Uint8Array {
  Uint8Array(value)
}

pub fn ToJsValue::to_js_value(value : Uint8Array) -> JsValue {
  value.0
}

pub extern "js" fn uint8array_new_ffi(length : Int) -> JsValue =
  #|(length) => new Uint8Array(length)

pub extern "js" fn uint8array_from_array_ffi(array : JsArray[JsValue]) -> JsValue =
  #|(array) => new Uint8Array(array)

pub extern "js" fn uint8array_from_buffer_ffi(buffer : JsValue, byte_offset : Int, length : Int) -> JsValue =
  #|(buffer, byte_offset, length) => new Uint8Array(buffer, byte_offset, length)

pub extern "js" fn uint8array_length_ffi(array : JsValue) -> Int =
  #|(array) => array.length

pub extern "js" fn uint8array_get_ffi(array : JsValue, index : Int) -> Int =
  #|(array, index) => array[index]

pub extern "js" fn uint8array_set_ffi(array : JsValue, index : Int, value : Int) -> Unit =
  #|(array, index, value) => array[index] = value

pub extern "js" fn uint8array_subarray_ffi(array : JsValue, start : Int, end : Int) -> JsValue =
  #|(array, start, end) => array.subarray(start, end)

pub extern "js" fn uint8array_copy_within_ffi(array : JsValue, target : Int, start : Int, end : Int) -> JsValue =
  #|(array, target, start, end) => array.copyWithin(target, start, end)

pub extern "js" fn uint8array_fill_ffi(array : JsValue, value : Int, start : Int, end : Int) -> JsValue =
  #|(array, value, start, end) => array.fill(value, start, end)

pub extern "js" fn uint8array_find_ffi(array : JsValue, predicate : (JsValue) -> JsValue) -> JsValue =
  #|(array, predicate) => array.find(predicate)

pub extern "js" fn uint8array_find_index_ffi(array : JsValue, predicate : (JsValue) -> JsValue) -> Int =
  #|(array, predicate) => array.findIndex(predicate)

pub extern "js" fn uint8array_sort_ffi(array : JsValue, compare_fn : (JsValue, JsValue) -> Int) -> JsValue =
  #|(array, compare_fn) => array.sort(compare_fn)

pub fn Uint8Array::new(length : Int) -> Uint8Array {
  uint8array_new_ffi(length) |> from_js_value
}

pub fn Uint8Array::from_array(array : Array[Int]) -> Uint8Array {
  uint8array_from_array_ffi(array.map(fn(i) { i |> to_js_value }) |> JsArray::from_array) |> from_js_value
}

pub fn Uint8Array::from_buffer(buffer : ArrayBuffer, byte_offset : Int, length : Int) -> Uint8Array {
  uint8array_from_buffer_ffi(buffer |> to_js_value, byte_offset, length) |> from_js_value
}

pub fn Uint8Array::length(self : Uint8Array) -> Int {
  uint8array_length_ffi(self |> to_js_value)
}

pub fn Uint8Array::get(self : Uint8Array, index : Int) -> Int {
  uint8array_get_ffi(self |> to_js_value, index)
}

pub fn Uint8Array::set(self : Uint8Array, index : Int, value : Int) -> Unit {
  uint8array_set_ffi(self |> to_js_value, index, value)
}

pub fn Uint8Array::subarray(self : Uint8Array, start : Int, end : Int) -> Uint8Array {
  uint8array_subarray_ffi(self |> to_js_value, start, end) |> from_js_value
}

pub fn Uint8Array::copy_within(self : Uint8Array, target : Int, start : Int, end : Int) -> Uint8Array {
  uint8array_copy_within_ffi(self |> to_js_value, target, start, end) |> from_js_value
}

pub fn Uint8Array::fill(self : Uint8Array, value : Int, start : Int, end : Int) -> Uint8Array {
  uint8array_fill_ffi(self |> to_js_value, value, start, end) |> from_js_value
}

pub fn Uint8Array::find(self : Uint8Array, predicate : (Int) -> Bool) -> JsValue {
  uint8array_find_ffi(self |> to_js_value, fn(v) { predicate(v |> from_js_value) |> to_js_value })
}

pub fn Uint8Array::find_index(self : Uint8Array, predicate : (Int) -> Bool) -> Int {
  uint8array_find_index_ffi(self |> to_js_value, fn(v) { predicate(v |> from_js_value) |> to_js_value })
}

pub fn Uint8Array::sort(self : Uint8Array, compare_fn : (Int, Int) -> Int) -> Uint8Array {
  uint8array_sort_ffi(self |> to_js_value, fn(a, b) { compare_fn(a |> from_js_value, b |> from_js_value) }) |> from_js_value
}
