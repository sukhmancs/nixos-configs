{ lib
, buildPythonPackage
, pythonOlder
, cmake
, pybind11
, spdlog
, numpy
}:

buildPythonPackage rec {
  pname = "starterpp";
  version = "1.0.0";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = ../.;

  propagatedBuildInputs = [
    numpy
  ];

  buildInputs = [
    pybind11
    spdlog
  ];

  nativeBuildInputs = [
    cmake
  ];

  dontUseCmakeConfigure = true;

  pythonImportCheck = [ "starterpp" ];

  meta = with lib; {
    description = ''
      An example nix powered pybind11 starter skeleton
    '';
    homepage = "https://github.com/nixvital/flake-templates/tree/main/templates/pybind11-starter-kit";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
