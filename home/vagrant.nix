{ 
inputs
, pkgs
, ... 
}: 

{ 
    imports = [ ./global ./features/term ]; 
}
