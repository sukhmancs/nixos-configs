# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  apple-fonts = {
    pname = "apple-fonts";
    version = "cad29b93d1abe93115f9ef71fc7c492f445d4c61";
    src = fetchFromGitHub {
      owner = "fefelixa";
      repo = "macfonts";
      rev = "cad29b93d1abe93115f9ef71fc7c492f445d4c61";
      fetchSubmodules = true;
      sha256 = "sha256-EsJA8c06h41iG/v/1Kh1i4lHlmXEgAFA6Qg9RVyCq8c=";
    };
    date = "2025-04-06";
  };
}
