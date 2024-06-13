pub type JsValue

pub trait ToJsValue {
  to_js_value(Self) -> JsValue
}

pub trait FromJsValue {
  from_js_value(JsValue) -> Self
}

pub fn to_js_value[T : ToJsValue](value : T) -> JsValue {
  value.to_js_value()
}

pub fn from_js_value[T : FromJsValue](value : JsValue) -> T {
  T::from_js_value(value)
}

pub extern "js" fn ToJsValue::to_js_value(_unit : Unit) -> JsValue = #|() => null

pub fn FromJsValue::from_js_value(_unit : JsValue) -> Unit {
  ()
}

pub extern "js" fn ToJsValue::to_js_value(value : Bool) -> JsValue = #|(n) => n

pub extern "js" fn FromJsValue::from_js_value(value : JsValue) -> Bool = #|(n) => n

pub extern "js" fn ToJsValue::to_js_value(value : Int) -> JsValue = #|(n) => n

pub extern "js" fn FromJsValue::from_js_value(value : JsValue) -> Int = #|(n) => n

pub extern "js" fn ToJsValue::to_js_value(value : Double) -> JsValue = #|(n) => n

pub extern "js" fn FromJsValue::from_js_value(value : JsValue) -> Double = #|(n) => n

pub fn ToJsValue::to_js_value(value : JsValue) -> JsValue {
  value
}

pub fn FromJsValue::from_js_value(value : JsValue) -> JsValue {
  value
}

pub extern "js" fn is_bool(self : JsValue) -> Bool = #|(n) => typeof n === 'boolean'

pub extern "js" fn is_null(self : JsValue) -> Bool = #|(n) => n === null

pub extern "js" fn is_undefined(self : JsValue) -> Bool = #|(n) => typeof n === 'undefined'

pub extern "js" fn is_number(self : JsValue) -> Bool = #|(n) => typeof n === 'number'

pub extern "js" fn is_string(self : JsValue) -> Bool = #|(n) => typeof n === 'string'

pub extern "js" fn is_object(self : JsValue) -> Bool = #|(n) => typeof n === 'object'

pub extern "js" fn is_symbol(self : JsValue) -> Bool = #|(n) => typeof n === 'symbol'

pub extern "js" fn is_function(self : JsValue) -> Bool = #|(n) => typeof n === 'function'

pub extern "js" fn get_globalThis() -> JsValue = #|() => globalThis

pub let globalThis : JsValue = get_globalThis()

/// https://tc39.es/ecma262/#sec-object-type
pub extern "js" fn get_ffi(self : JsValue, key : JsValue) -> JsValue = #|(object, key) => object[key]

pub fn get_with_string_js[T : FromJsValue](
  self : JsValue,
  key : JsString
) -> T {
  self.get_ffi(key |> to_js_value) |> from_js_value
}

pub fn get_with_string[T : FromJsValue](self : JsValue, key : String) -> T {
  self.get_with_string_js(JsString::from_string(key))
}

pub fn get_with_symbol[T : FromJsValue](self : JsValue, key : JsSymbol) -> T {
  self.get_ffi(key |> to_js_value) |> from_js_value
}

pub fn get_with_index[T : FromJsValue](self : JsValue, index : Int) -> T {
  self.get_ffi(index |> to_js_value) |> from_js_value
}

/// https://tc39.es/ecma262/#sec-object-type
pub extern "js" fn set_ffi(self : JsValue, key : JsValue, value : JsValue) = #|(object, key, value) => { object[key] = value }

pub fn set_with_string[T : ToJsValue](
  self : JsValue,
  key : JsString,
  value : T
) -> Unit {
  self.set_ffi(key |> to_js_value, value |> to_js_value)
}

pub fn set_with_symbol[T : ToJsValue](
  self : JsValue,
  key : JsSymbol,
  value : T
) -> Unit {
  self.set_ffi(key |> to_js_value, value |> to_js_value)
}

pub fn set_with_index[T : ToJsValue](
  self : JsValue,
  index : Int,
  value : T
) -> Unit {
  self.set_ffi(index |> to_js_value, value |> to_js_value)
}

pub extern "js" fn JsValue::null() -> JsValue = #|() => null

pub extern "js" fn JsValue::undefined() -> JsValue = #|() => undefined

pub extern "js" fn JsValue::apply_ffi(
  self : JsValue,
  this : JsValue,
  args : JsValue
) -> JsValue =
  #|(func, thisArg, args) => func.apply(thisArg, args)

pub fn JsValue::apply_js[This : ToJsValue, Arg : ToJsValue, Result : FromJsValue](
  self : JsValue,
  this : This,
  args : JsArray[Arg]
) -> Result {
  self.apply_ffi(this |> to_js_value, args |> to_js_value) |> from_js_value
}

pub fn JsValue::apply[This : ToJsValue, Arg : ToJsValue, Result : FromJsValue](
  self : JsValue,
  this : This,
  args : Array[Arg]
) -> Result {
  self.apply_js(this, JsArray::from_array(args))
}

pub extern "js" fn JsValue::call_ffi(
  self : JsValue,
  this : JsValue,
  args : JsValue
) -> JsValue =
  #|(func, thisArg, ...args) => func.call(thisArg, ...args)

pub fn JsValue::call_js[This : ToJsValue, Arg : ToJsValue, Result : FromJsValue](
  self : JsValue,
  this : This,
  args : JsArray[Arg]
) -> Result {
  self.call_ffi(this |> to_js_value, args |> to_js_value) |> from_js_value
}

pub fn JsValue::call[This : ToJsValue, Arg : ToJsValue, Result : FromJsValue](
  self : JsValue,
  this : This,
  args : Array[Arg]
) -> Result {
  self.call_js(this, JsArray::from_array(args))
}

pub extern "js" fn JsValue::bind_ffi(
  self : JsValue,
  this : JsValue,
  args : JsValue
) -> JsValue =
  #|(func, thisArg, ...args) => func.bind(thisArg, ...args)

pub fn JsValue::bind_js[This : ToJsValue, Arg : ToJsValue, Result : FromJsValue](
  self : JsValue,
  this : This,
  args : JsArray[Arg]
) -> Result {
  self.bind_ffi(this |> to_js_value, args |> to_js_value) |> from_js_value
}

pub fn JsValue::bind[This : ToJsValue, Arg : ToJsValue, Result : FromJsValue](
  self : JsValue,
  this : This,
  args : Array[Arg]
) -> Result {
  self.bind_js(this, JsArray::from_array(args))
}
