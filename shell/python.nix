{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python";
  buildInputs = with pkgs; [
    python312
    python312Packages.virtualenv
    python312Packages.netifaces
  ];

  shellHook = ''
    if [ ! -d ".venv" ]; then
      python3 -m venv .venv
      source .venv/bin/activate
    else
      source .venv/bin/activate
    fi
  '';
}