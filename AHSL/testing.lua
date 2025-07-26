--!ahsl
local maxDistance=20;
local testpart=PartIndexing.GetPartsWithIndex(3)[1];
local click=Instance.new("ClickDetector",testpart);
click.MaxActivationDistance=maxDistance;