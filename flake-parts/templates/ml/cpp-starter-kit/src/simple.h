#pragma once

namespace simple {

template <typename ValueType>
auto Add(const ValueType &a, const ValueType &b) -> ValueType {
  return a + b;
}

int Subtract(int a, int b);

} // namespace simple
