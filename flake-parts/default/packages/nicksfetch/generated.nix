# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  nicksfetch = {
    pname = "nicksfetch";
    version = "ccd5d9f52609bbdcd5d8fa78c4fdb0f12954125f";
    src = fetchFromGitHub {
      owner = "dylanaraps";
      repo = "neofetch";
      rev = "ccd5d9f52609bbdcd5d8fa78c4fdb0f12954125f";
      fetchSubmodules = false;
      sha256 = "sha256-XAg9X6NnfdoxH0A9M2pnN6pSwk9rCC9s3fsOmHo3eJ8=";
    };
    date = "2021-12-10";
  };
}
