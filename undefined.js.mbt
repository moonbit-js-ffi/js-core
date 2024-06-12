pub type Optional[T] JsValue

pub fn FromJsValue::from_js_value[T](value : JsValue) -> Optional[T] {
  Optional(value)
}

pub fn ToJsValue::to_js_value[T](value : Optional[T]) -> JsValue {
  value.0
}

pub fn is_undefined[T](self : Optional[T]) -> Bool {
  self.0.is_undefined()
}

pub fn to_option[T : FromJsValue](self : Optional[T]) -> Option[T] {
  if self.0.is_undefined() {
    None
  } else {
    Some(from_js_value(self.0))
  }
}
