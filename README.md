# Slingshot

Slingshot is a small library for light and ergonomic functional programming in Swift.

It is designed to fit nicely with existing Swift structures and enhance them with additional superpowers, like `Optional` and `Result`.

This ensures that this library is easy to learn and minimal enough where you don't have to re-learn what you know,
or to re-write your application to use it.

## Alternatives to Slingshot

### Bow

Bow is a functional programming library for Swift that is very complete, powerful and popular.

It has support for far many more features than Slingshot, like Do notation, emulated HKTs and trampolining.

Unfortunately it can be daunting to add to an existing project because instead of enhancing the native Swift `Optional` and `Result`,
Bow uses its own custom `Option` and `Either` types.

While conversion methods between the native and Bow versions are available, this still requires you to have two different
representations of what an optional type is in your code, adding both a learning curve and code noise if you want to interop with existing code. 

Slingshot has a different philosophy, in that it wants to enhance existing Swift structures, not replace them.
This lightweight approach comes at the expense of having less extra features, but allows a smaller learning curve and a smaller footprint,
making it easy to add to existing projects.

All in all, if you prefer a more lightweight approach and don't mind not having Bow's extra features, Slingshot could be for you.
