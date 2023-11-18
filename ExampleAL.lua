local vis=Instance.new('Model', workspace)
vis.Name='Visualizer'
local al=require(workspace.AudioLib)
if (al.Initialized~=true) then
    al:Init()
end
local actx=al:Create()
local src=actx:CreateMediaInstanceSource(workspace.Sound)
local analyser=actx:CreateAnalyser()
src:Connect(analyser)


