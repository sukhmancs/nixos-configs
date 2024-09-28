{
  stdenv,
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,
  rustPlatform,
  numpy
}:

buildPythonPackage rec {
  pname = "maturin-basics";
  version = "0.1.0";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = ../../..;

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-tMd3EH3ruSGZkKLA7Lac0uOFcuZcYd+dsIsP1xaEisc=";
  };

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    maturinBuildHook
  ];

  propagatedBuildInputs = [
    numpy
  ];

  pythonImportsCheck = [ "maturin_basics" ];
}
