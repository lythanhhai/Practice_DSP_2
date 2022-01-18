function [min] = findMin(vectorDistance)
   min = vectorDistance(1);
   for i=2:length(vectorDistance)
       if vectorDistance(i) < min
           min = vectorDistance(i);
       end
   end
end