{
  lib,
  buildGradle,
  pkgs,
}:
buildGradle {
  pname = "my-java-app";
  version = "1.0.0";

  src = ./.;

  buildInputs = [pkgs.gradle];

  meta = with lib; {
    description = "My Java application built with Gradle";
    license = licenses.mit;
    maintainers = with maintainers; [xi];
  };
}
