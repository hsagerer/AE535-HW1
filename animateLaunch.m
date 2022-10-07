function [k] = animateLaunch(Time,Radius,Speed,Nu,Psi,PlanetRadius,OrbitalAltitude,FPS,FrameTime)
%ANIMATELAUNCH creates a animated plot of the launch trajectory relative to
%the Earth and a target orbital radius
%   Inputs are: Time [s], Radial position [m], Speed [m/s], Nu [rad],
%   Flight-path-angle [rad], PlanetRadius [m], Orbital atltitude [m], Frames per second, Time step per frame [s] 
%   DO NOT CHANGE FIGURE DURING ANIMATION
k=figure;
second=gca;
viscircles([0 0],PlanetRadius/1e3,'Color','g');
hold on 
viscircles([0 0],PlanetRadius/1e3+OrbitalAltitude/1e3,'Color','c','LineStyle','--','LineWidth',.2);
xlabel('[km]')
ylabel('[km]')

maxY=  PlanetRadius/1e3 + 10;
minY = PlanetRadius/1e3 - 50;
minX = -50;
maxX = 50;

scale=1.03;
h = [];

for ii=1:FrameTime:round(Time(end)-1)
    ind1=find(Time>=ii,1,'first');
    ind2=find(Time>=ii+FrameTime,1,'first');
    if ~isempty(ind2)
    x1 = sin(Nu(ind1)).*Radius(ind1)/1e3;
    x2 = sin(Nu(ind2)).*Radius(ind2)/1e3;
    y1 = cos(Nu(ind1)).*Radius(ind1)/1e3;
    y2 = cos(Nu(ind2)).*Radius(ind2)/1e3;
    %delete(h) 
    h = plot(second, [x1 x2],[y1 y2],'x-','Color','k');

    if y2>maxY
        maxY=scale*y2;
    end
    if y2<minY
        if minY>0
            minY=(1/scale)*y2;
        else
            minY=scale*y2;
        end
    end
    if x2 > maxX
       maxX=scale*x2;
    end
    if x2 < minX
        if minX>0
            minX=(1/scale)*x2;
        else
            minX=scale*x2;
        end
    end
    axis([minX maxX minY maxY])
    %h = scatter(second, sin(Nu(ii))*(Radius(ii)/1e3+Re/1e3), cos(Nu(ii))*(Radius(ii)/1e3+Re/1e3),'x');
    title(second,['Time: ', num2str(round(Time(ind2)))])
    drawnow
    pause(1/FPS)
    end
end
pause(5)
axis([-(PlanetRadius+2*OrbitalAltitude) (PlanetRadius+2*OrbitalAltitude) -(PlanetRadius+2*OrbitalAltitude) (PlanetRadius+2*OrbitalAltitude)]/1e3)
axis square
drawnow
end

