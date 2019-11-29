
function rho = find_rho(B, m, oper)
    L = 0; R = 3*m; m_ = m/oper; iter=0;
    B_log = log(B);
    format long
    while(iter<20)
        iter = iter+1;
        mid = (L+R)/2.0;
        sum = 0;
        for k = 0:m_
            sum = sum + ((power(sym(mid), k)/factorial(sym(k))));
        end
        test_B_log = m_*log(mid) - log(factorial(sym(m_))) - log(sum);
        if (test_B_log > B_log)
            R = mid;
        else
            L = mid;
        end   
    end
    rho = mid;
end


