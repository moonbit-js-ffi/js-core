type JsArray[T] JsValue

pub extern "js" fn JsArray::new_ffi() -> JsValue =
  #|() => []

pub extern "js" fn JsArray::mapp_ffi(
  self : JsValue,
  f : (JsValue) -> JsValue
) -> JsValue =
  #|() => []

pub extern "js" fn JsArray::push_ffi(self : JsValue, value : JsValue) =
  #|(array, value) => { array.push(value) }

pub extern "js" fn JsArray::length_ffi(self : JsValue) -> Int =
  #|(array) => array.length

pub fn FromJsValue::from_js_value[T](value : JsValue) -> JsArray[T] {
  JsArray(value)
}

pub fn ToJsValue::to_js_value[T](arr : JsArray[T]) -> JsValue {
  arr.0
}

pub fn JsArray::new[T]() -> JsArray[T] {
  JsArray(JsArray::new_ffi())
}

pub fn get[T : FromJsValue](self : JsArray[T], index : Int) -> T {
  self.0.get_with_index(index)
}

pub fn push[T : ToJsValue](self : JsArray[T], value : T) -> Unit {
  self.0 |> push_ffi(to_js_value(value))
}

pub fn length[T](self : JsArray[T]) -> Int {
  length_ffi(self.0)
}

pub fn JsArray::to_array[T : FromJsValue](value : JsArray[T]) -> Array[T] {
  let array = Array::with_capacity(value.length())
  for i = 0; i < value.length(); i = i + 1 {
    array.push(value.get(i))
  }
  array
}

pub fn JsArray::from_array[T : ToJsValue](arr : Array[T]) -> JsArray[T] {
  let array = JsArray::new()
  arr.iter(fn { v => array.push(v) })
  array
}
