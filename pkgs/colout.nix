{ lib
, babel
, buildPythonPackage
, fetchPypi
, pygments
}:

buildPythonPackage rec {
  pname = "colout";
  version = "0.12.1";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    sha256 = "fa689ba585f5a7dc0630ab8bf85fba7c7985e741d0c82cbeeedd7633ecba63de";
  };

  propagatedBuildInputs = [ babel pygments ];

  pythonImportsCheck = [ "colout" ];

  meta = with lib; {
    description = "Color Up Arbitrary Command Output";
    homepage = "http://nojhan.github.com/colout/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ badele ];
  };
}
