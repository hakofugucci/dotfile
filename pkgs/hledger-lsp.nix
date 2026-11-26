{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "hledger-lsp";
  version = "0.2.53";

  src = fetchFromGitHub {
    owner = "juev";
    repo = "hledger-lsp";
    rev = "v${version}";
    hash = "sha256-/kwj5Qz9NBv+roD64VNLYVL6WtiHUPkZTFLLHls9ERQ=";
  };

  vendorHash = "sha256-imF6wCMC+5J94TQjZU0SXOwlw5SR/EB60GeYVS3O/iA=";

  subPackages = [ "cmd/hledger-lsp" ];

  meta = {
    description = "Language Server Protocol implementation for hledger journals";
    homepage = "https://github.com/juev/hledger-lsp";
    license = lib.licenses.mit;
    mainProgram = "hledger-lsp";
  };
}
