{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, zlib
, stdenv
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-edit";
  version = "0.11.3";

  src = fetchFromGitHub {
    owner = "killercup";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-xhUI8rkABw3Op3sTctAIL7nCTX6Ejl2jMr0RI4oERIU=";
  };

  cargoSha256 = "sha256-7Of641eBgXqa6vaAr4NotDScGPRd+RcTzWRmIn8pEeU=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl zlib ] ++ lib.optionals stdenv.isDarwin [
    Security
  ];

  doCheck = false; # integration tests depend on changing cargo config

  meta = with lib; {
    description = "A utility for managing cargo dependencies from the command line";
    homepage = "https://github.com/killercup/cargo-edit";
    changelog = "https://github.com/killercup/cargo-edit/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ Br1ght0ne figsoda gerschtli jb55 killercup ];
  };
}
