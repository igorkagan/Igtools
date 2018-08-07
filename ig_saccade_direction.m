function Direction = ig_saccade_direction(x,y)
%IG_SACCADE_DIRECTION		- saccade direction

Direction = [];

Angle_ = abs(atan(y./x)*180/pi); % in degrees

% Quadrants
% II  | I
% --------
% III | IV


for k = 1:length(x)

        if y(k) >= 0 & x(k) >= 0,     % I quadrant
                Direction(k) = Angle_(k);
        elseif y(k) >= 0 & x(k) < 0,  % II quadrant
                Direction(k) = 180 - Angle_(k);
        elseif y(k) <= 0 & x(k) <= 0, % III quadrant
                Direction(k) = 180 + Angle_(k);
        else 			% IV quadrant
                Direction(k) = 360 - Angle_(k);
        end
end