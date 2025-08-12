--!ahsl
RunAdonisCommand(":touchexe 6 started .1 1 :trip exe");
task.spawn(function()
    while PartIndexing.GetPartsWithIndex(6)[1] do
        RunAdonisCommand(":rotatepart 6 relative 0,90,0 5 Linear Out");
        task.wait(5);
        if not running then
            break;
        end;
    end;
end);