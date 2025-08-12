--!ahsl
RunAdonisCommand(":touchexe 6 started .1 1 :trip exe");
task.spawn(function()
    while PartIndexing.GetPartsWithIndex(6)[1] do
        RunAdonisCommand(":rotatepart 6 relative 0,90,0 5 Linear Out");
        task.wait(5);
        if not PartIndexing.GetPartsWithIndex(6)[1] then
            warn("No parts with index 6 exist, Loop will be terminated");
            break;
        end;
    end;
end);