function pheromone=initial_pheromone(pheromone,point_end)
%% 
%point_end   input       ÷’µ„
%pheromone   output      –≈œ¢Àÿ

for x=1:200
    for y=1:200
        for z=1:200
            pheromone(x,y,z)=5000/distance(x,y,z,point_end(1),point_end(2),point_end(3));
        end
    end
end
