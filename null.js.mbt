pub type Nullable[T] JsValue

pub fn FromJsValue::from_js_value[T](value : JsValue) -> Nullable[T] {
  Nullable(value)
}

pub fn ToJsValue::to_js_value[T](value : Nullable[T]) -> JsValue {
  value.0
}

pub fn is_null[T](self : Nullable[T]) -> Bool {
  self.0.is_null()
}

pub fn unwrap[T : FromJsValue](self : Nullable[T]) -> T {
  self.0 |> from_js_value
}

pub fn to_option[T : FromJsValue](self : Nullable[T]) -> Option[T] {
  @option.unless(self.is_null(), fn() { self.unwrap() })
}
