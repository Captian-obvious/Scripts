local c=owner.Character or owner.CharacterAdded:Wait()
local h=c:FindFirstChildOfClass('Humanoid')
local al=require(workspace.AudioLib)
if (al.Initialized~=true) then
    al:Init()
end
local actx=al:Create()
local src=actx:CreateMediaInstanceSource(workspace.Sound)
local analyser=actx:CreateAnalyser()
src:Connect(analyser)
if (h~=nil) then
    local root=h.RootPart
    function createVisualizer(parent,n,radius)
        local vis=Instance.new('Model', workspace)
        vis.Name='Visualizer'
        local angleStep=(math.pi*2)/n
        for i=1,n do
            local angle=angleStep*(i-1)
            local part=Instance.new('Part',vis)
            local pos=circle(root.Position,angle)
            part.CFrame=CFrame.new(pos,root.Position)
            part.Anchored=true
            part.TopSurface=Enum.SurfaceType.Smooth
            part.BottomSurface=Enum.SurfaceType.Smooth
            part.Name=tostring(i)
        end
    end
end
