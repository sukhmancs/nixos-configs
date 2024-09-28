#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
#include <unordered_set>

namespace py = pybind11;

int CountUniqueIntegers(py::array_t<int> input_array) {
    py::buffer_info buf_info = input_array.request();
    int *ptr = static_cast<int *>(buf_info.ptr);
    int length = buf_info.size;

    std::unordered_set<int> unique_set(ptr, ptr + length);
    return unique_set.size();
}

PYBIND11_MODULE(starterpp, m) {
  m.def("count_unique_integers", &CountUniqueIntegers, "Count unique integers in a numpy array",
        py::arg("input_array").noconvert());
}
