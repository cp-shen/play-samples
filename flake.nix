{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      jdk = pkgs.javaPackages.compiler.temurin-bin.jdk-21;
      jre = jdk.jre;
      coursier = pkgs.coursier.override { inherit jre; };
      metals = pkgs.metals.override { inherit jre coursier; };
      sbt = pkgs.sbt.override { inherit jre; };
    in
    {
      devShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          jdk
          coursier
          metals
          sbt
        ];
      };
    }
  );
}
