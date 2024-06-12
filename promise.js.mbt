struct Promise[T] {
  val : JsValue
}

pub fn FromJsValue::from_js_value[T](value : JsValue) -> Promise[T] {
  { val: value }
}

pub fn ToJsValue::to_js_value[T](value : Promise[T]) -> JsValue {
  value.val
}

pub extern "js" fn then_ffi(
  promise : JsValue,
  f : (JsValue) -> JsValue
) -> JsValue =
  #|(p, func) => p.then(func)

pub extern "js" fn then_with_error_ffi(
  promise : JsValue,
  f : (JsValue) -> JsValue,
  e : (JsValue) -> JsValue
) -> JsValue =
  #|(p, func, error) => p.then(func, error)

pub extern "js" fn catch_ffi(
  promise : JsValue,
  f : (JsValue) -> JsValue
) -> JsValue =
  #|(p, func) => p.catch(func)

pub extern "js" fn finally_ffi(
  promise : JsValue,
  f : (JsValue) -> JsValue
) -> JsValue =
  #|(p, func) => p.finally(func)

pub extern "js" fn new_promise_ffi(
  func : ((JsValue) -> Unit, (JsValue) -> Unit) -> Unit
) -> JsValue =
  #|(func) => new Promise(func)

pub fn map[A : FromJsValue, B : ToJsValue](
  self : Promise[A],
  f : (A) -> B
) -> Promise[B] {
  Promise::{
    val: self.val |> then_ffi(fn { a => f(a |> from_js_value) |> to_js_value }),
  }
}

pub fn bind[A : FromJsValue, B : ToJsValue](
  self : Promise[A],
  f : (A) -> Promise[B]
) -> Promise[B] {
  Promise::{
    val: self.val |> then_ffi(fn { a => (a |> from_js_value |> f).val }),
  }
}

pub extern "js" fn Promise::resolve_ffi(value : JsValue) -> JsValue =
  #|(v) => Promise.resolve(v)

pub extern "js" fn Promise::reject_ffi(value : JsValue) -> JsValue =
  #|(v) => Promise.reject(v)

pub fn Promise::resolve[A : ToJsValue](value : A) -> Promise[A] {
  { val: resolve_ffi(value.to_js_value()) }
}

pub fn Promise::reject[A : ToJsValue](value : A) -> Promise[A] {
  { val: reject_ffi(value.to_js_value()) }
}

pub fn Promise::new[A : ToJsValue](
  f : ((A) -> Unit, (JsValue) -> Unit) -> Unit
) -> Promise[A] {
  let func = fn(resolve, reject) {
    f(
      fn { value => resolve(value |> to_js_value) },
      fn { reason => reject(reason) },
    )
  }
  Promise::{ val: new_promise_ffi(func) }
}

pub fn Promise::then[A : FromJsValue, B : ToJsValue](
  self : Promise[A],
  f : (A) -> B
) -> Promise[B] {
  Promise::{
    val: self.val |> then_ffi(fn { a => f(a |> from_js_value) |> to_js_value }),
  }
}

pub fn Promise::then_with_error[A : FromJsValue, B : ToJsValue, C : ToJsValue](
  self : Promise[A],
  f : (A) -> B,
  e : (JsValue) -> C
) -> Promise[B] {
  Promise::{
    val: self.val
    |> then_with_error_ffi(
      fn { a => f(a |> from_js_value) |> to_js_value },
      fn { error => e(error) |> to_js_value },
    ),
  }
}

pub fn Promise::catch_[A : FromJsValue, B : ToJsValue](
  self : Promise[A],
  f : (JsValue) -> B
) -> Promise[A] {
  Promise::{
    val: self.val |> catch_ffi(fn { error => f(error) |> to_js_value }),
  }
}

pub fn Promise::finally[A : FromJsValue](
  self : Promise[A],
  f : () -> Unit
) -> Promise[A] {
  Promise::{ val: self.val |> finally_ffi(fn { _u => f() |> to_js_value }) }
}

pub extern "js" fn race_ffi(promises : JsArray[JsValue]) -> JsValue =
  #|(promises) => Promise.race(promises)

pub extern "js" fn all_ffi(promises : JsArray[JsValue]) -> JsValue =
  #|(promises) => Promise.all(promises)

pub fn Promise::race[A : ToJsValue](promises : Array[A]) -> Promise[A] {
  Promise::{
    val: race_ffi(
      promises.map(fn { p => p.to_js_value() }) |> JsArray::from_array,
    ),
  }
}

pub fn Promise::all[A : ToJsValue](promises : Array[A]) -> Promise[A] {
  Promise::{
    val: all_ffi(
      promises.map(fn { p => p.to_js_value() }) |> JsArray::from_array,
    ),
  }
}
