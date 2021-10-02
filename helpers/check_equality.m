%% Aux func
function L = check_equality(a, b)
    % Check if both terms are equal up to a precision
    if abs(a-b) < 10e-5
        L = true;
    else
        L = false;
    end
end

