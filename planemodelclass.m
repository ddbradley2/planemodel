clear all;

gridWidth = 10;
gridHeight = 10;
numberSearchPlanes = 5;
numberSteps = 100;

classdef (Sealed) VehicleType
    properties (Constant)
        PLANE = 1;
        SHIP = 2;
        HELICOPTER = 3;
    end

    methods (Access = private)    % private so that you cant instantiate
        function out = VehicleType
        end
    end
end

classdef Flow
	properties
		% instance variables
		X = zeros(gridWidth, gridHeight);
		Y = zeros(gridWidth, gridHeight);
	end
	methods
		% constructor
		function newFlow = Flow(X,Y)
			newFlow.X(:,:) = X(:,:);
			newFlow.Y(:,:) = Y(:,:);
		end
		% instance methods
	end
end

classdef Path
	properties (SetAccess = private)
		X;
		Y;
		currentStep;
	end
	methods
		function newPath = Path()
			newPath.X = zeros(numberSteps);
			newPath.Y = zeros(numberSteps);	
			currentStep = 1;
		end

		function setNextPosition(newX, newY)
			currentStep += 1;
			X(currentStep) = newX;
			Y(currentStep) = newY;
		end

		function ret = getCurrentX()
			ret = X(currentStep);
		end

		function ret = getCurrentY()
			ret = Y(currentStep);
		end
	end
end

classdef Vehicle
	properties
		Flow;
		VehicleType;
		Path;
	end
	methods
		function newVeh = Vehicle(Flow, X, Y, VehicleType)
			newVeh.Flow = Flow;
			newVeh.VehicleType = VehicleType;
			newVeh.Path = Path();
			newVeh.Path.setNextPosition(x, Y);	
		end
		function move()
			oldX = Path.getCurrentX();
			oldY = Path.getCurrentY();
			
			Path.setNextPosition(oldX + Flow.X(oldX, oldY), 

oldY + Flow.Y(oldX, oldY));
		end	
	end
end		

planeX = zeros(numberSteps);
planeY = zeros(numberSteps);
planeX(1) = gridWidth / 2; % plane start x
planeY(1) = gridHeight / 2; % plane start y

searchPlaneX = zeros(numberSearchPlanes, numberSteps); % i, t
searchPlaneY = zeros(numberSearchPlanes, numberSteps); % i, t
for i=1:numberSearchPlanes
    searchPlaneX(i,1) = 1;
    searchPlaneY(i,1) = i*2 - 1;
end

oceanFlowX = zeros(gridWidth, gridHeight);
oceanFlowY = zeros(gridWidth, gridHeight);
for i=1:10
    for j=1:10
        oceanFlowX(i,j) = 0;
        oceanFlowY(i,j) = 0;
    end
end

searchFlowX = zeros(gridWidth, gridHeight);
searchFlowY = zeros(gridWidth, gridHeight);
for i=1:10
    for j=1:10
        searchFlowX(i,j) = 1;
        searchFlowY(i,j) = 0;
    end
end

for n=1:numberSteps
    clf
    axis([1,gridWidth,1,gridHeight])
    hold on
    axis manual
    
    planeX(n+1) = planeX(n) + oceanFlowX(planeX(n), planeY(n));
    planeY(n+1) = planeY(n) + oceanFlowY(planeX(n), planeY(n));
    
    for i=1:numberSearchPlanes
        searchPlaneX(i,n+1) = searchPlaneX(i,n) + searchFlowX(searchPlaneX

(i,n), searchPlaneY(i,n));
        searchPlaneY(i,n+1) = searchPlaneY(i,n) + searchFlowY(searchPlaneX

(i,n), searchPlaneY(i,n));
    end
    
    scatter(planeX(n),planeY(n))
    scatter(searchPlaneX(:,n),searchPlaneY(:,n))
    
    pause;
end
