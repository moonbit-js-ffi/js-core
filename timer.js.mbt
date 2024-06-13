pub extern "js" fn set_timeout_ffi(
  callback : () -> Unit,
  delay : Int,
  args : JsValue
) -> JsValue =
  #|(callback, delay, ...args) => setTimeout(callback, delay, ...args)

pub fn set_timeout[Arg : ToJsValue](
  callback : () -> Unit,
  delay : Int,
  args : Array[Arg]
) -> JsValue {
  set_timeout_ffi(callback, delay, JsArray::from_array(args) |> to_js_value)
}

pub extern "js" fn clear_timeout_ffi(timeout_id : JsValue) -> Unit =
  #|(timeoutId) => clearTimeout(timeoutId)

pub fn clear_timeout(timeout_id : JsValue) -> Unit {
  clear_timeout_ffi(timeout_id)
}

pub extern "js" fn set_interval_ffi(
  callback : () -> Unit,
  interval : Int,
  args : JsValue
) -> JsValue =
  #|(callback, interval, ...args) => setInterval(callback, interval, ...args)

pub fn set_interval[Arg : ToJsValue](
  callback : () -> Unit,
  interval : Int,
  args : Array[Arg]
) -> JsValue {
  set_interval_ffi(callback, interval, JsArray::from_array(args) |> to_js_value)
}

pub extern "js" fn clear_interval_ffi(interval_id : JsValue) -> Unit =
  #|(intervalId) => clearInterval(intervalId)

pub fn clear_interval(interval_id : JsValue) -> Unit {
  clear_interval_ffi(interval_id)
}

pub extern "js" fn set_immediate_ffi(
  callback : () -> Unit,
  args : JsValue
) -> JsValue =
  #|(callback, ...args) => setImmediate(callback, ...args)

pub fn set_immediate[Arg : ToJsValue](
  callback : () -> Unit,
  args : Array[Arg]
) -> JsValue {
  set_immediate_ffi(callback, JsArray::from_array(args) |> to_js_value)
}

pub extern "js" fn clear_immediate_ffi(immediate_id : JsValue) -> Unit =
  #|(immediateId) => clearImmediate(immediateId)

pub fn clear_immediate(immediate_id : JsValue) -> Unit {
  clear_immediate_ffi(immediate_id)
}
