fn init {
  @js.Console::log_(@js.JsString::from_string("Hello, World!"))
  @js.Console::warn(@js.JsString::from_string("waring"))
  @js.log(@js.JsString::from_string("Hello, World!"))
  @js.logMany(
    [@js.JsString::from_string("Hello,"), @js.JsString::from_string("World!")],
  )
}

fn init {
  @js.Promise::new(
    fn {
      resolve, _reject => {
        @js.log(@js.JsString::from_string("promise"))
        resolve(@js.JsArray::[1, 2, 3] |> @js.to_js_value)
      }
    },
  )
  |> @js.Promise::then(
    fn { _val => @js.log(@js.JsString::from_string("promise")) },
  )
  |> @js.Promise::then_with_error(
    fn { val => val |> ignore },
    fn { err => err |> ignore },
  )
  |> @js.Promise::catch_(
    fn { _e => @js.log(@js.JsString::from_string("error")) },
  )
  |> ignore
  @js.Promise::all(
    [
      @js.Promise::resolve(@js.JsString::from_string("test1")),
      @js.Promise::resolve(@js.JsString::from_string("test2")),
    ],
  )
  |> ignore
}

fn init {
  let a = @js.JsFunction::new(fn { x => @js.log(x + 1) })
  a |> @js.call(@js.null(), [12])
}
