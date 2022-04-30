clear
close all
clc

gravity=9.81; % Starting gravity value

airResistance=0.24; % Air resistance is accepted as 0.24


enteredValue= 'Enter the drop height ' ; % User can enter the height value
x = input(enteredValue);

enteredMassOne= 'Enter the mass of red object ' ;
enteredMassRed = input(enteredMassOne);

enteredMassTwo= 'Enter the mass of red object ' ;
enteredMassBlue = input(enteredMassTwo);

newtonFalling(x,gravity,enteredMassRed,enteredMassBlue,airResistance)
% This code simulates the fall of 2 objects of different mass in
% plane with air resistance and plane without air resistance
function newtonFalling(h,g,m1,m2,airResistanceK) % Newton falling function
    k=airResistanceK;
    height=h;
    gravity=g;
    fallTime=0; % It is a variable according to the object which falls latest
    fallTimeGreen=(2*height/gravity)^(1/2); % Since (gt^2/2)=h => t = (2h/g)^1/2
    
    fallTimeRed=fallCalcul(gravity,0.24,m1,height);
    fallTimeBlue=fallCalcul(gravity,0.24,m2,height);
    
    fallTime=fallTimeRed;
    if fallTimeBlue>fallTimeRed
       fallTime=fallTimeBlue;
    end
    ax1=subplot(2,2,1);
    ax2=subplot(2,2,2);
    ax3=subplot(2,2,[3,4]);
    
    t=0; % Starting time is 0
    while (true)

        subplot(ax3)
        line(ax3,[0 0], [0 height*10/9]) % Divider of planes
        title('Ball falling simulation');
        ylabel('Height (m)');
        xlabel('Ground');
        ylim([0 height*10/9]);% In order to visualize the falling upper 
                              % limit of graph needs to stays still
        xlim([-10 10]);
        if fallTimeGreen>t
            plot(4,(height)-(t*t*gravity/2),'g.','MarkerSize',8*m1);
            plot(8,(height)-(t*t*gravity/2),'g.','MarkerSize',8*m2);
        end
        
        if fallTimeRed>t
            plot(-8,(height)-(m1/k)*log((cosh(t*(g*k/m1)^(1/2)))),'r.','MarkerSize',8*m1);
        end
        
        if fallTimeRed<=t
            plot(-8,0,'r.','MarkerSize',8*m1);
        end  
        if fallTimeBlue>t
            plot(-4,(height)-(m2/k)*log((cosh(t*(g*k/m2)^(1/2)))),'b.','MarkerSize',8*m2);
        end
        if fallTimeBlue<=t
            plot(-4,0,'b.','MarkerSize',8*m2);
        end
        
        % Masses are proportional to the ball sizes because I accepted
        % them as same material so mass depends on size
        text(-8,height*1/4,'With air resistance','Color','red','FontSize',12)
        text(2,height*1/4,'Without air resistance','Color','red','FontSize',12)

        % This part prints the distance traveled over time simultaneously
                      
        hold on
        subplot(ax2)
        title('Height of the balls');
        ylabel('Height (m)');
        xlabel('Time(s)');
        xlim([-.3 fallTime*10/9]);
        ylim([0 height*10/9]);
        a = 0:.1:t; % a is for making graphs of distance and velocity over 
                    % time. Since t is a constant number
                    % plot function wouldn't work beause of unmatched sizes
                    % so we create a matrice
        plot(a,height-a.*a*g/2,'g',a,height-(m1/k)*log((cosh(a*(g*k/m1)^(1/2)))),'r',a,height-(m2/k)*log((cosh(a*(g*k/m2)^(1/2)))),'b');

        hold off
        
        % This part prints the graph of velocity over time simultaneously
                        % of velocity over time simultaneously
        hold on
        subplot(ax1)
        plot(a,a*g,'g',a,((m1*g/k)^(1/2))*tanh(a/((m1/(g*k))^(1/2))),'r',a,((m2*g/k)^(1/2))*tanh(a/((m2/(g*k))^(1/2))),'b'); % Derivating time in (g*t^2)/2 to find change 
                         % in velocity -> g*t

        title('Velocity of the balls');
        ylabel('Velocity (m/s)');
        xlabel('Time(s)');
        xlim([-.3 fallTime*10/9]);
        ylim([-.3 fallTimeGreen*g]);

        hold off
        
        if fallTimeGreen<t
            plot(ax3,4,0,'g.','MarkerSize',8*m1);
            plot(ax3,8,0,'g.','MarkerSize',8*m2);
        end
        pause(.001)

        cla(ax3) % Clears the dots created on falling simulator


        
        if fallTime<t
            break % Breaks out of while loop
        end
        t=t+.1; % Current time increases here
        
    end
    plot(ax3,4,0,'g.','MarkerSize',8*m1);
    plot(ax3,8,0,'g.','MarkerSize',8*m2);
    plot(ax3,-8,0,'r.','MarkerSize',8*m1);
    plot(ax3,-4,0,'b.','MarkerSize',8*m2);
    
    line(ax3,[0 0], [0 height*10/9])
    text(ax3,-8,height*1/4,'With air resistance','Color','red','FontSize',12)
    text(ax3,2,height*1/4,'Without air resistance','Color','red','FontSize',12)
    fprintf('\n')
    fprintf('Green objects hit the ground after %.2f seconds \n',fallTimeGreen)
    fprintf('Red object hit the ground after %.2f seconds \n',fallTimeRed)
    fprintf('Blue object hit the ground after %.2f seconds \n',fallTimeBlue)
    
end



function value=fallCalcul(gravity,constant,massOfObject,length)
    e=2.71;
    h=length;
    g=gravity;
    k=constant;
    m=massOfObject;

value=(m/(g*k))^(1/2)*acosh(e^(h*k/m));
    
end
