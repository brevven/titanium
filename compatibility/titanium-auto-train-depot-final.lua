local util = require("data-util");

if mods.AutoTrainDepot then
  util.remove_prerequisite("depot-fluid", "nickel-processing")
end
