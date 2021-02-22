# This file has been generated by node2nix 1.9.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? []}:

let
  sources = {
    "isexe-2.0.0" = {
      name = "isexe";
      packageName = "isexe";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz";
        sha1 = "e8fbf374dc556ff8947a10dcb0572d633f2cfa10";
      };
    };
    "shell-quote-1.7.2" = {
      name = "shell-quote";
      packageName = "shell-quote";
      version = "1.7.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/shell-quote/-/shell-quote-1.7.2.tgz";
        sha512 = "mRz/m/JVscCrkMyPqHc/bczi3OQHkLTqXHEFu0zDhK/qfv3UcOA4SVmRCLmos4bhjr9ekVQubj/R7waKapmiQg==";
      };
    };
    "uuid-3.4.0" = {
      name = "uuid";
      packageName = "uuid";
      version = "3.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/uuid/-/uuid-3.4.0.tgz";
        sha512 = "HjSDRw6gZE5JMggctHBcjVak08+KEVhSIiDzFnT9S9aegmp85S/bReBVTb4QTFaRNptJ9kuYaNhnbNEOkbKb/A==";
      };
    };
    "vscode-jsonrpc-6.0.0" = {
      name = "vscode-jsonrpc";
      packageName = "vscode-jsonrpc";
      version = "6.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-jsonrpc/-/vscode-jsonrpc-6.0.0.tgz";
        sha512 = "wnJA4BnEjOSyFMvjZdpiOwhSq9uDoK8e/kpRJDTaMYzwlkrhG1fwDIZI94CLsLzlCK5cIbMMtFlJlfR57Lavmg==";
      };
    };
    "vscode-languageserver-6.1.1" = {
      name = "vscode-languageserver";
      packageName = "vscode-languageserver";
      version = "6.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver/-/vscode-languageserver-6.1.1.tgz";
        sha512 = "DueEpkUAkD5XTR4MLYNr6bQIp/UFR0/IPApgXU3YfCBCB08u2sm9hRCs6DxYZELkk++STPjpcjksR2H8qI3cDQ==";
      };
    };
    "vscode-languageserver-protocol-3.16.0" = {
      name = "vscode-languageserver-protocol";
      packageName = "vscode-languageserver-protocol";
      version = "3.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-protocol/-/vscode-languageserver-protocol-3.16.0.tgz";
        sha512 = "sdeUoAawceQdgIfTI+sdcwkiK2KU+2cbEYA0agzM2uqaUy2UpnnGHtWTHVEtS0ES4zHU0eMFRGN+oQgDxlD66A==";
      };
    };
    "vscode-languageserver-textdocument-1.0.1" = {
      name = "vscode-languageserver-textdocument";
      packageName = "vscode-languageserver-textdocument";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-textdocument/-/vscode-languageserver-textdocument-1.0.1.tgz";
        sha512 = "UIcJDjX7IFkck7cSkNNyzIz5FyvpQfY7sdzVy+wkKN/BLaD4DQ0ppXQrKePomCxTS7RrolK1I0pey0bG9eh8dA==";
      };
    };
    "vscode-languageserver-types-3.16.0" = {
      name = "vscode-languageserver-types";
      packageName = "vscode-languageserver-types";
      version = "3.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-types/-/vscode-languageserver-types-3.16.0.tgz";
        sha512 = "k8luDIWJWyenLc5ToFQQMaSrqCHiLwyKPHKPQZ5zz21vM+vIVUSvsRpcbiECH4WR88K2XZqc4ScRcZ7nk/jbeA==";
      };
    };
    "vscode-uri-2.1.2" = {
      name = "vscode-uri";
      packageName = "vscode-uri";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-uri/-/vscode-uri-2.1.2.tgz";
        sha512 = "8TEXQxlldWAuIODdukIb+TR5s+9Ds40eSJrw+1iDDA9IFORPjMELarNQE3myz5XIkWWpdprmJjm1/SxMlWOC8A==";
      };
    };
    "which-2.0.2" = {
      name = "which";
      packageName = "which";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/which/-/which-2.0.2.tgz";
        sha512 = "BLI3Tl1TW3Pvl70l3yq3Y64i+awpwXqsGBYWkkqMtnbXgrMD+yj7rhW0kuEDxzJaYXGjEW5ogapKNMEKNMjibA==";
      };
    };
  };
in
{
  purescript-language-server = nodeEnv.buildNodePackage {
    name = "purescript-language-server";
    packageName = "purescript-language-server";
    version = "0.14.4";
    src = fetchurl {
      url = "https://registry.npmjs.org/purescript-language-server/-/purescript-language-server-0.14.4.tgz";
      sha512 = "qsyk0PNStUQJnoxZKPAO0QTRBsZ2fu/PZwfMIAv6b1lHbdi5fsyC7BdCtZxzwAO2hF0OxCIANEeRkbUi+e55Fg==";
    };
    dependencies = [
      sources."isexe-2.0.0"
      sources."shell-quote-1.7.2"
      sources."uuid-3.4.0"
      sources."vscode-jsonrpc-6.0.0"
      sources."vscode-languageserver-6.1.1"
      sources."vscode-languageserver-protocol-3.16.0"
      sources."vscode-languageserver-textdocument-1.0.1"
      sources."vscode-languageserver-types-3.16.0"
      sources."vscode-uri-2.1.2"
      sources."which-2.0.2"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Language Server Protocol server for PureScript wrapping purs ide server functionality";
      homepage = "https://github.com/nwolverson/purescript-language-server";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
