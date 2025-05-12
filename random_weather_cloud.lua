local HttpService = game:GetService("HttpService");
local apiKey = "YOUR_API_KEY";
local locations ={"New York",""}; -- You can randomize this!
local the_yes_message="Listen, buddy. I am the MOST accurate forecast in the universe. YOU just don't understand my methods.";
-- "99999999999% accurate forecast"
function getForecast(location)
    local thecondition=nil;
    local url = "http://api.weatherapi.com/v1/current.json?key=" .. apiKey .. "&q=" .. location;
    local success, response = pcall(function()
        return HttpService:GetAsync(url);
    end);
    if success then
        local data = HttpService:JSONDecode(response);
        print("Weather in " .. location .. ": " .. data.current.condition.text);
        thecondition=data.current.condition.text;
    else
        print("Failed to fetch weather data!");
    end;
    return thecondition;
end;
function animateCloud(condition, cloud)
    if condition:lower():find("rain") then
        cloud.RainEmitter.Enabled = true; -- Rain effect
        cloud.dl.weatherchat.forecast.ResponseDialog="rain" -- temporary message
    elseif condition:lower():find("thunder") then
        cloud.Transparency = 0.5;
        cloud.SoundEffect:Play(); -- Thunder sound
        cloud.dl.weatherchat.forecast.ResponseDialog="thunder" -- temporary message
    elseif condition:lower():find("sunny") then
        cloud.Size = cloud.Size * 0.9; -- Shrinking in the heat
        cloud.dl.weatherchat.forecast.ResponseDialog="sun" -- temporary message
    elseif condition:lower():find("snow") then
        cloud.SnowEmitter.Enabled = true; -- Snow particles
        cloud.dl.weatherchat.forecast.ResponseDialog="snow" -- temporary message
    elseif condition:lower():find("fog") then
        cloud.Transparency = 0.8; -- Mysterious foggy cloud
        cloud.dl.weatherchat.forecast.ResponseDialog="foggy" -- temporary message
    elseif condition:lower():find("wind") then
        cloud.Position = cloud.Position + Vector3.new(math.random(-1,1), 0, math.random(-1,1)); -- Wobbly movement
        cloud.dl.weatherchat.forecast.ResponseDialog="windy" -- temporary message
    end;
end;
-- above here we have the cloud defined
function random_forecast()
    local chosenLocation=locations[math.random(1,#locations)];
    local theweather=getForecast(chosenLocation);
    animateCloud(theweather,thecloudpart);

end;