local ts=game:GetService("TweenService");
local cameraShake=require(127899128442444);
local dynamicExplosion = require(11380416673);
local sf=workspace:FindFirstChild("MusicFolder") or Instance.new('Folder',workspace);
sf.Name="MusicFolder";
function makeSound(id,vol,loop,name, pitch)
    pitch = pitch or 1;
    local s = Instance.new('Sound', sf);
    s.SoundId = id;
    s.Volume = vol;
    s.Looped = loop;
    s.Pitch = pitch;
    s.Name = name;
    return s;
end;
local kaboom = sf:FindFirstChild('kaboom') or makeSound('rbxassetid://131026234',1.5,false,'kaboom');
local countdown=sf:FindFirstChild('tentozero') or makeSound("rbxassetid://15487574881",3,false,'tentozero');
local sdm1=sf:FindFirstChild('t6min') or makeSound("rbxassetid://1000895732",2,false,'t6min');
local music1=sf:FindFirstChild('music1') or makeSound("rbxassetid://9254549777",2,false,'music1');
while not music1.IsLoaded do
  task.wait()
end;
music1:Play();
sdm1:Play();