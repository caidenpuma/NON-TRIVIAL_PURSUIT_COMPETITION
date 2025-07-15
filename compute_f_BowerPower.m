function F = compute_f_BowerPower(t,Frmax,Fymax,amiapredator,pr,vr,Er,py,vy,Ey)


% PLEASE FILL OUT THE INFORMATION BELOW WHEN YOU SUBMIT YOUR CODE
% Test time and place: 1:30pm @bh 096
% Group members:Dhaamin Buford,Caiden Puma,Justin Moustouka,Brian Delgado


%   t: Time
%   Frmax: Max force that can act on the predator
%   Fymax: Max force that can act on th eprey
%   amiapredator: Logical variable - if amiapredator is true,
%   the function must compute forces acting on a predator.
%   If false, code must compute forces acting on a prey.
%   pr - 2D column vector with current position of predator eg pr = [x_r;y_r]
%   vr - 2D column vector with current velocity of predator eg vr= [vx_r;vy_r]
%   Er - energy remaining for predator
%   py - 2D column vector with current position of prey py = [x_prey;y_prey]
%   vy - 2D column vector with current velocity of prey py = [vx_prey;vy_prey]
%   Ey - energy remaining for prey
%   F - 2D column vector specifying the force to be applied to the object
%   that you wish to control F = [Fx;Fy]
%   The direction of the force is arbitrary, but if the
%   magnitude you specify exceeds the maximum allowable
%   value its magnitude will be reduced to this value
%   (without changing direction)

    g = 9.81;
    mr = 100; % Mass of predator, in kg
    my = 10.; % Mass of prey, in kg
    predator_crash_limit = 15; % Predator max landing speed to survive
    prey_crash_limit = 8; % Prey max landing speed to survive
    Max_fuel_r = 500000; % Max stored energy for predator
    Max_fuel_y = 50000;  % Max stored energy for prey
    
    h_crit_y = 1.5*(0.5*my*norm(vy)^2)/(Fymax-(my*g));
    h_crit_r = 1.5*(0.5*mr*norm(vr)^2)/(Frmax-(mr*g));

    dt = 5;
    predictdiry = ((py+vy*dt)-(pr+vr*dt))/norm((py+vy*dt)-(pr+vr*dt));

  % Code to compute the force to be applied to the predator

  if (amiapredator)
      if (t<5)
          F = Frmax*[0;1];
      else
         if (Er<150000)
          if (pr(2)>h_crit_r)
              F = 0*[0;1];
              if (pr(2) == h_crit_r)
                  F = Frmax*[0;1];
              end
          elseif (pr(2)<h_crit_r)
              F = Frmax*(vr/(-1*norm(vr+0.25))); %Force opposes current motion in i and j
              if(pr(2) == h_crit_r)
                  F = [0;0];
              end
      if (norm(pr-py)<10)
          dt = 3;
      end          
          end                  
         else
             F = Frmax*predictdiry + (mr*g + 1000/(pr(2)+0.25))*[0;1];
         end
      end
  else     
    if (t<5)
          F = Fymax*[0;1]; 
    else
         if (Ey<14000)
          if (py(2)>h_crit_y)
              F = Fymax/2*[0;-1];
              if (py(2) == h_crit_y)
                  F = Fymax*[0;1];
              end
          elseif (py(2)<h_crit_y)
              F = Fymax*(vy/(-1*norm(vy+0.25))); %Force opposes current motion in i and j
              if (py(2) == h_crit_y)
                  F = [0;0];
              end            
          end        
         else
             F = Fymax/sqrt(2)*cos(t)*[1;0] + (Fymax/sqrt(2)*sin(t) + my*g + 1000/(py(2)+0.25))*[0;1]; 
          if (norm(py-pr)<50)
              F = Fymax*((py+vy*cos(t))-(pr+vr*sin(t)))/norm((py+vy*cos(t))-(pr+vr*sin(t))) + (my*g + 1000/(py(2)+0.25))*[0;1];
            if (norm(py-pr)<15)
                F = Fymax/sqrt(2)*cos(t)*[1;0] + (Fymax/sqrt(2)*sin(t) + my*g + 1000/(py(2)+0.25))*[0;1];
            end            
          end
         end
    end
  end                  
  end
