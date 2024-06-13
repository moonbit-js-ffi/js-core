pub type Console JsValue

pub extern "js" fn console_log_ffi(message : JsValue) =
  #|(message) => console.log(message)

pub extern "js" fn console_log_many_ffi(message : JsArray[JsValue]) =
  #|(message) => console.log(...message)

pub extern "js" fn console_warn_ffi(message : JsValue) =
  #|(message) => console.warn(message)

pub extern "js" fn console_error_ffi(message : JsValue) =
  #|(message) => console.error(message)

pub extern "js" fn console_info_ffi(message : JsValue) =
  #|(message) => console.info(message)

pub extern "js" fn console_debug_ffi(message : JsValue) =
  #|(message) => console.debug(message)

pub fn Console::log_[T : ToJsValue](message : T) -> Unit {
  console_log_ffi(message.to_js_value())
}

pub fn Console::logMany_[T : ToJsValue](message : Array[T]) -> Unit {
  console_log_many_ffi(
    message.map(fn { m => m.to_js_value() }) |> JsArray::from_array,
  )
}

pub fn Console::warn[T : ToJsValue](message : T) -> Unit {
  console_warn_ffi(message.to_js_value())
}

pub fn Console::error[T : ToJsValue](message : T) -> Unit {
  console_error_ffi(message.to_js_value())
}

pub fn Console::info[T : ToJsValue](message : T) -> Unit {
  console_info_ffi(message.to_js_value())
}

pub fn Console::debug[T : ToJsValue](message : T) -> Unit {
  console_debug_ffi(message.to_js_value())
}

pub fn log[T : ToJsValue](msg : T) -> Unit {
  console_log_ffi(msg.to_js_value())
}

pub fn logMany[T : ToJsValue](msg : Array[T]) -> Unit {
  console_log_many_ffi(
    msg.map(fn { m => m.to_js_value() }) |> JsArray::from_array,
  )
}
